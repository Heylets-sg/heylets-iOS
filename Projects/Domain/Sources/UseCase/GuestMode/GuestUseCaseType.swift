//
//  GuestUseCaseType.swift
//  Domain
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol GuestUseCaseType {
    var errMessage: PassthroughSubject<String, Never> { get }
    
    func changeGuestUniversity(university: String) -> AnyPublisher<Void, Never>
    func startGuestMode(university: String) -> AnyPublisher<Void, Never>
}
