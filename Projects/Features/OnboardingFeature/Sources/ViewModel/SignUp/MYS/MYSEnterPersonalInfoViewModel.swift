import Foundation
import Combine

import BaseFeatureDependency
import Domain
import DSKit
import Core

@MainActor
public class MYSEnterPersonalInfoViewModel: ObservableObject {
    struct State {
        var passwordIsValid: TextFieldState = .idle
        var checkPasswordIsValid: TextFieldState = .idle
        var birthDateIsValid: TextFieldState = .idle
        var continueButtonIsEnabled: Bool = false
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case genderButtonDidTap(Gender)
    }
    
    @Published var gender: Gender? = nil
    @Published var birth: Date = Date()
    @Published var birthDate: String = ""
    @Published var password = ""
    @Published var checkPassword = ""
    
    @Published var state = State()
    public var navigationRouter: NavigationRoutableType
    private var useCase: SignUpUseCaseType
    private let cancelBag = CancelBag()
    
    public init(
        navigationRouter: NavigationRoutableType,
        useCase: SignUpUseCaseType
    ) {
        self.navigationRouter = navigationRouter
        self.useCase = useCase
        
        observe()
    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            navigationRouter.pop()
            
        case .nextButtonDidTap:
            guard let gender else { return }
            useCase.userInfo.password = password
            useCase.userInfo.gender = gender.rawValue
            useCase.userInfo.birth = birth
            useCase.userInfo.agreements = AgreementInfo.agreementList
            navigationRouter.push(to: .enterReferralCode)
            
        case .genderButtonDidTap(let gender):
            self.gender = gender
        }
    }
    
    private func observe() {
        weak var owner = self
        guard let owner else { return }
        
        $password
            .map { $0.isEmpty ? .idle : ($0.isValidPassword() ? .valid : .invalid) }
            .assign(to: \.state.passwordIsValid, on: owner)
            .store(in: cancelBag)
        
        $checkPassword
            .map { $0.isEmpty ? .idle : ($0 == self.password ? .valid : .invalid) }
            .assign(to: \.state.checkPasswordIsValid, on: owner)
            .store(in: cancelBag)
        
        // birthDate 처리 추가
        $birthDate
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .map { birth in
                let formatted = self.formatDateString(birth)
                if birth != formatted {
                    DispatchQueue.main.async {
                        self.birthDate = formatted
                    }
                }
                return formatted
            }
            .sink { [weak self] formattedDate in
                guard let self = self else { return }
                
                // 날짜 유효성 확인
                if birthDate.isEmpty {
                    self.state.birthDateIsValid = .idle
                } else {
                    if self.checkIsValidDateType() {
                        self.convertBirthDateToDate()
                        self.state.birthDateIsValid = .valid
                    } else {
                        self.state.birthDateIsValid = .invalid
                    }
                }
                
            }
            .store(in: cancelBag)
        
        // 버튼 활성화 조건 업데이트
        Publishers.CombineLatest4($gender, $password, $checkPassword, $birthDate)
            .receive(on: RunLoop.main)
            .map { gender, password, checkPassword, birthDate in
                return gender != nil &&
                       owner.state.passwordIsValid == .valid &&
                       owner.state.checkPasswordIsValid == .valid &&
                       owner.state.birthDateIsValid == .valid
            }
            .assign(to: \.state.continueButtonIsEnabled, on: owner)
            .store(in: cancelBag)
    }
}

extension MYSEnterPersonalInfoViewModel {
    // 형식 변환 메소드
    private func formatDateString(_ rawText: String) -> String {
        let digits = rawText.filter { $0.isNumber } // 숫자만 남기기
        var formattedText = ""
        
        for (index, char) in digits.enumerated() {
            if index == 4 || index == 6 {
                // 4번째, 6번째 문자 뒤에 '/' 삽입
                formattedText.append(" / ")
            }
            formattedText.append(char)
        }
        
        return formattedText.prefix(14).description // 최대 길이 제한
    }
    
    // 날짜 유효성 확인 메소드
    private func checkIsValidDateType() -> Bool {
        let digits = birthDate.filter { $0.isNumber }
        
        // 생년월일 타입 변환 String -> Int
        guard digits.count == 8,
              let year = Int(digits.prefix(4)),
              let month = Int(digits.dropFirst(4).prefix(2)),
              let day = Int(digits.dropFirst(6).prefix(2)),
              (1...12).contains(month)
        else {
            return false
        }
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.calendar = Calendar.current
        
        guard let date = components.date,
              let range = Calendar.current.range(
                of: .day,
                in: .month,
                for: date
              ),
              range.contains(day)
        else {
            return false
        }
        
        // 추가 유효성 검사: 미래 날짜가 아닌지, 나이 제한 등
        return isValidBirth(date)
    }
    
    // birthDate가 유효한지 확인하는 헬퍼 메서드
    private func isValidBirth(_ date: Date) -> Bool {
        // 1. 날짜가 과거인지 확인
        guard date < Date() else { return false }
        
        // 2. 나이 제한 확인 (예: 13세 이상)
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
        guard let age = ageComponents.year, age >= 13 else { return false }
        
        // 3. 너무 오래된 날짜는 아닌지 확인 (예: 100세 이하)
        guard age <= 100 else { return false }
        
        return true
    }
    
    // 텍스트에서 Date 객체로 변환하는 메서드
    private func convertBirthDateToDate() {
        let digits = birthDate.filter { $0.isNumber }
        guard digits.count == 8,
              let year = Int(digits.prefix(4)),
              let month = Int(digits.dropFirst(4).prefix(2)),
              let day = Int(digits.dropFirst(6).prefix(2)) else {
            return
        }
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.calendar = Calendar.current
        
        if let date = components.date {
            self.birth = date
        }
    }
}
