//
//  GuestUseCase.swift
//  Domain
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import Core

final public class GuestUseCase: GuestUseCaseType {
    private let guestRepository: GuestRepositoryType
    private var cancelBag = CancelBag()
    
    public var errMessage = PassthroughSubject<String, Never>()
    
    public init(guestRepository: GuestRepositoryType) {
        self.guestRepository = guestRepository
    }
    
//    public func changeGuestUniversity(university: String) -> AnyPublisher<Void, Never> {
//        guestRepository.changeGuestUniversity(university: university)
//            .catch { [weak self] error in
//                self?.errMessage.send("대학교 변경에 실패했습니다.")
//                return Empty<Void, Never>()
//            }
//            .eraseToAnyPublisher()
//    }
    
    public func startGuestMode(university: String) -> AnyPublisher<Void, Never> {
        guestRepository.startGuestMode(university: university)
            .map { _ in }
            .catch { [weak self] error in
                self?.errMessage.send("게스트 모드 시작에 실패했습니다.")
                return Empty<Void, Never>()
            }
            .eraseToAnyPublisher()
    }
}

final public class StubGuestUseCase: GuestUseCaseType {
    public var errMessage = PassthroughSubject<String, Never>()
    
    public func changeGuestUniversity(university: String) -> AnyPublisher<Void, Never> {
        return Just(()).eraseToAnyPublisher()
    }
    
    public func startGuestMode(university: String) -> AnyPublisher<Void, Never> {
        return Just(()).eraseToAnyPublisher()
    }
}
