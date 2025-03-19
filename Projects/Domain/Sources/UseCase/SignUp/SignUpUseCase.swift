//
//  OnboardingUseCase.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

final public class SignUpUseCase: SignUpUseCaseType {
    private let authRepository: AuthRepositoryType
    private let guestRepository: GuestRepositoryType
    private var cancelBag = CancelBag()
    
    public var errMessage = PassthroughSubject<String, Never>()
    
    public init(
        authRepository: AuthRepositoryType,
        guestRepository: GuestRepositoryType
    ) {
        self.authRepository = authRepository
        self.guestRepository = guestRepository
    }
    
    public var userInfo: User = .empty
    
    public func signUp() -> AnyPublisher<Void, Never> {
        guestRepository.checkGuestMode()  // 게스트 모드 여부를 확인
            .flatMap { [weak self] isGuest in
                guard let self else { return Empty<Void, Never>().eraseToAnyPublisher() }
                print("isGuest: \(isGuest)")
                if isGuest {
                    return self.guestRepository.convertToMember(userInfo)
                        .handleEvents(receiveOutput: { _ in
                            Analytics.shared.track(.userSignedUp)
                        })
                        .map { _ in }
                        .catch { [weak self] error in
                            self?.errMessage.send(error.description)
                            return Empty<Void, Never>()
                        }
                        .eraseToAnyPublisher()
                } else {
                    Analytics.shared.track(.clickFinishSignUp)
                    return self.authRepository.signUp(userInfo)
                        .handleEvents(receiveOutput: { _ in
                            Analytics.shared.track(.guestConverted)
                        })
                        .map { _ in }
                        .catch { [weak self] error in
                            self?.errMessage.send(error.description)
                            return Empty<Void, Never>()
                        }
                        .eraseToAnyPublisher()
                }
            }
            .eraseToAnyPublisher()
    }
    
    public func requestEmailVerifyCode(
        _ email: String
    ) -> AnyPublisher<Void, Never> {
            authRepository.requestVerifyEmail(email)
                .map { _ in }
                .catch { [weak self] error in
                    self?.errMessage.send(error.description)
                    return Empty<Void, Never>()
                }
                .eraseToAnyPublisher()
        
    }
    
    public func verifyEmail(
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Never> {
        authRepository.verifyEmail(email, otpCode)
            .map { _ in }
            .catch { [weak self] _ in
                self?.errMessage.send("Incorrect security code. Check your code and try again")
                return Empty<Void, Never>()
            }
            .eraseToAnyPublisher()
        
    }

    public func checkUserName(
        _ userName: String
    ) -> AnyPublisher<Bool, Never> {
        authRepository.checkUserName(userName)
            .map { $0 }
            .catch { [weak self] _ in
                self?.errMessage.send("The format of the name is incorrect.")
                return Empty<Bool, Never>()
            }
            .eraseToAnyPublisher()
    }
    
    public func startGuestMode(university: UniversityInfo, agreements: [AgreementInfo]) -> AnyPublisher<Void, Never> {
        guestRepository.startGuestMode(
            university: university.rawValue,
            agreements: agreements
        )
        .map { _ in }
        .catch { [weak self] error in
            self?.errMessage.send("게스트 모드 시작에 실패했습니다. \(error)")
            return Empty<Void, Never>()
        }
        .eraseToAnyPublisher()
    }
}

final public class StubSignUpUseCase: SignUpUseCaseType {
    public var userInfo: User = .empty
    public var errMessage = PassthroughSubject<String, Never>()
    
    public func signUp() -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func requestEmailVerifyCode(
        _ email: String
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func verifyEmail(
        _ email: String,
        _ otpCode: Int
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
    
    public func checkUserName(
        _ userName: String
    ) -> AnyPublisher<Bool, Never> {
        Just(true).eraseToAnyPublisher()
    }
    
    public func startGuestMode(
        university: UniversityInfo,
        agreements: [AgreementInfo]
    ) -> AnyPublisher<Void, Never> {
        Just(()).eraseToAnyPublisher()
    }
}
