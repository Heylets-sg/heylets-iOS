//
//  GuestRepository.swift
//  Data
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain
import Networks
import Core

public struct GuestRepository: GuestRepositoryType {
    public let userService: UserServiceType
    public let guestService: GuestServiceType
    
    public init(
        userService: UserServiceType,
        guestService: GuestServiceType
    ) {
        self.userService = userService
        self.guestService = guestService
    }
    
    public func checkGuestMode() -> AnyPublisher<Bool, Never> {
        Just(AppSettingsStorage.isGuestMode())
            .eraseToAnyPublisher()
    }
    
    public func changeGuestUniversity(university: String) -> AnyPublisher<Void, Error> {
        guestService.changeGuestUniversity(university)
            .asVoidWithGeneralError()
    }
    
    public func startGuestMode(
        university: String,
        agreements: [AgreementInfo]
    ) -> AnyPublisher<Auth, Error> {
        let request = GuestAgreementRequest(agreements: agreements.map { $0.toDTO() })
        return guestService.startGuestMode(university, request)
            .handleEvents(receiveOutput: { token in
                SecureTokenStorage.setAuthTokens(
                    access: token.access_token,
                    refresh: token.refresh_token
                )
                AppSettingsStorage.setGuestMode(true)
            })
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
    
    public func convertToMember(_ user: User) -> AnyPublisher<Void, SignUpError> {
        let request: GuestSignUpRequest = user.toDTO()
        if Config.isDevEnvironment {
            return guestService.testConvertToMember(request)
                .handleEvents(receiveOutput: { token in
                    SecureTokenStorage.clearAuthTokens()
                    AppSettingsStorage.setGuestMode(false)
                })
                .mapError { error in
                    if let errorCode = error.isInvalidStatusCode() {
                        return SignUpError.error(with: errorCode)
                    } else {
                        return .unknown
                    }
                }
                .eraseToAnyPublisher()
        } else {
            return guestService.convertToMember(request)
                .handleEvents(receiveOutput: { token in
                    SecureTokenStorage.clearAuthTokens()
                    AppSettingsStorage.setGuestMode(false)
                })
                .mapError { error in
                    if let errorCode = error.isInvalidStatusCode() {
                        return SignUpError.error(with: errorCode)
                    } else {
                        return .unknown
                    }
                }
                .eraseToAnyPublisher()
        }
    }
}

