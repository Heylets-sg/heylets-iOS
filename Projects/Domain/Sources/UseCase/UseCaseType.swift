//
//  UseCaseType.swift
//  Domain
//
//  Created by 류희재 on 1/13/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public protocol UseCaseType: ObservableObject {
    var myPageUseCase: MyPageUseCaseType { get }
    var signUpUseCase: SignUpUseCaseType { get }
    var signInUseCase: SignInUseCaseType { get }
    var timeTableUseCase: TimeTableUseCaseType { get }
    var splashUseCase: SplashUseCaseType { get }
    var todoUseCase: TodoUsecaseType { get }
}

public final class HeyUseCase: UseCaseType {
    
    var repository: RepositoryType
    
    public var splashUseCase: SplashUseCaseType
    public var myPageUseCase: MyPageUseCaseType
    public var signUpUseCase: SignUpUseCaseType
    public var signInUseCase: SignInUseCaseType
    public var timeTableUseCase: TimeTableUseCaseType
    public var todoUseCase: TodoUsecaseType
    
    public init(repository: RepositoryType) {
        self.repository = repository
        
        splashUseCase = SplashUseCase(
            authRepository: repository.authRepository
        )
        
        myPageUseCase = MyPageUseCase(
            userRepository: repository.userRepository,
            authRepository: repository.authRepository,
            guestRepository: repository.guestRepository,
            referralRepository: repository.referralRepository,
            notificationRepository: repository.notificationRepository
        )
        
        signUpUseCase = SignUpUseCase(
            authRepository: repository.authRepository,
            userRepository: repository.userRepository,
            guestRepository: repository.guestRepository,
            referralRepository: repository.referralRepository
        )
        
        signInUseCase = SignInUseCase(
            authRepository: repository.authRepository,
            guestRepository: repository.guestRepository
        )
        
        timeTableUseCase = TimeTableUseCase(
            userRepository: repository.userRepository,
            lectureRepository: repository.lectureRepository,
            scheduleRepository: repository.scheduleRepository,
            sectionRepository: repository.sectionRepository,
            settingRepository: repository.settingRepository,
            timeTableRepository: repository.timeTableRepository,
            guestRepository: repository.guestRepository
        )
        
        todoUseCase = TodoUseCase(
            timeTableRepository: repository.timeTableRepository,
            todoRepository: repository.todoRepository,
            guestRepository: repository.guestRepository
        )
    }
}

public final class StubHeyUseCase: UseCaseType {
    public init() {}
    
    public var splashUseCase: SplashUseCaseType = StubSplashUseCase()
    public var myPageUseCase: MyPageUseCaseType = StubMyPageUseCase()
    public var signUpUseCase: SignUpUseCaseType = StubSignUpUseCase()
    public var signInUseCase: SignInUseCaseType = StubSignInUseCase()
    public var timeTableUseCase: TimeTableUseCaseType = StubTimeTableUseCase()
    public var todoUseCase: TodoUsecaseType = StubTodoUseCase()
}

@MainActor
extension StubHeyUseCase {
    static public let `stub` = StubHeyUseCase()
}
