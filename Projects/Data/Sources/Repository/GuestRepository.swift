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
        Just(UserDefaultsManager.isGuestMode)
            .eraseToAnyPublisher()
    }
    
    public func changeGuestUniversity(university: String) -> AnyPublisher<Void, Error> {
        guestService.changeGuestUniversity(university)
            .asVoidWithGeneralError()
    }
    
    public func startGuestMode(university: String) -> AnyPublisher<Auth, Error> {
        guestService.startGuestMode(university)
            .handleEvents(receiveOutput: { token in
                UserDefaultsManager.setToken(token)
                UserDefaultsManager.isGuestMode = true
            })
            .map { $0.toEntity() }
            .mapToGeneralError()
    }
}

//    public func convertToMember() {
//        <#code#>
//    }


