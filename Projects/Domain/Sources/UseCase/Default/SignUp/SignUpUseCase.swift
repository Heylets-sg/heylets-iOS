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
    private let userRepository: UserRepositoryType
    private let guestRepository: GuestRepositoryType
    private let referralRepository: ReferralRepositoryType
    private var cancelBag = CancelBag()
    
    public var errMessage = PassthroughSubject<String, Never>()
    
    public init(
        authRepository: AuthRepositoryType,
        userRepository: UserRepositoryType,
        guestRepository: GuestRepositoryType,
        referralRepository: ReferralRepositoryType
    ) {
        self.authRepository = authRepository
        self.userRepository = userRepository
        self.guestRepository = guestRepository
        self.referralRepository = referralRepository
    }
    
    public var userInfo: User = .empty
    
    public func checkGuestMode() -> AnyPublisher<Bool, Never> {
        return guestRepository.checkGuestMode()
    }
    
    public func signUp() -> AnyPublisher<Void, Never> {
        guestRepository.checkGuestMode()
            .flatMap { [weak self] isGuest in
                guard let self else { return Empty<Void, Never>().eraseToAnyPublisher() }
                if isGuest {
                    return self.guestRepository.convertToMember(userInfo)
                        .handleEvents(receiveOutput: { _ in
                            Analytics.shared.track(.guestConverted)
                            
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
                        .handleEvents(
                            receiveOutput: { _ in
                            Analytics.shared.track(.userSignedUp)
                        }, receiveRequest: { _ in
                            print("🏡🏡🏡🏡🏡🏡🏡🏡🏡🏡🏡")
                            dump(self.userInfo)
                            print("🏡🏡🏡🏡🏡🏡🏡🏡🏡🏡🏡")
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
    
    public func getUniversityInfo() -> AnyPublisher<UniversityInfo, Never> {
        userRepository.getProfile()
            .map { $0.university }
            .catch { [weak self] error in
                self?.errMessage.send("대학교를 찾지 못했습니다 \(error)")
                return Just(UniversityInfo.empty).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    public func checkReferraalCode(_ code: String) -> AnyPublisher<Bool, Never> {
        referralRepository.validateReferralCode(code)
            .map { $0 }
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.userInfo.referralCode = code
            })
            .catch { _ in Just(false).eraseToAnyPublisher() }
            .eraseToAnyPublisher()
    }
}

