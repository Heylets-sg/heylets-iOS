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
    
    var timeTableStore: TimeTableStoreType { get }
    var mainUseCase: MainUseCaseType { get }
    var searchUseCase: SearchUseCaseType { get }
    var settingUseCase: SettingUseCaseType { get }
    
    var splashUseCase: SplashUseCaseType { get }
    var todoUseCase: TodoUsecaseType { get }
}

public final class HeyUseCase: UseCaseType {
    var repository: RepositoryType
    
    public var splashUseCase: SplashUseCaseType
    public var myPageUseCase: MyPageUseCaseType
    public var signUpUseCase: SignUpUseCaseType
    public var signInUseCase: SignInUseCaseType
    
    public var timeTableStore: TimeTableStoreType
    public var mainUseCase: MainUseCaseType
    public var searchUseCase: SearchUseCaseType
    public var settingUseCase: SettingUseCaseType
    
    public var todoUseCase: TodoUsecaseType
    
    public init(repository: RepositoryType) {
        self.repository = repository
        timeTableStore = TimeTableStore(timeTableRepository: repository.timeTableRepository)
        
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
        
        mainUseCase = MainUseCase(
            store: timeTableStore,
            userRepository: repository.userRepository,
            scheduleRepository: repository.scheduleRepository,
            sectionRepository: repository.sectionRepository,
            settingRepository: repository.settingRepository,
            timeTableRepository: repository.timeTableRepository
        )
        
        searchUseCase = SearchUseCase(
            store: timeTableStore,
            lectureRepository: repository.lectureRepository,
            scheduleRepository: repository.scheduleRepository
        )
        
        settingUseCase = SettingUseCase(
            store: timeTableStore,
            userRepository: repository.userRepository,
            sectionRepository: repository.sectionRepository,
            guestRepository: repository.guestRepository,
            timeTableRepository: repository.timeTableRepository,
            settingRepository: repository.settingRepository
        )
        
        
        
        todoUseCase = TodoUseCase(
            timeTableRepository: repository.timeTableRepository,
            todoRepository: repository.todoRepository,
            guestRepository: repository.guestRepository
        )
    }
}

//public final class StubHeyUseCase: UseCaseType {
//    public init() {}
//    
//    public var splashUseCase: SplashUseCaseType = StubSplashUseCase()
//    public var myPageUseCase: MyPageUseCaseType = StubMyPageUseCase()
//    public var signUpUseCase: SignUpUseCaseType = StubSignUpUseCase()
//    public var signInUseCase: SignInUseCaseType = StubSignInUseCase()
////    public var timeTableUseCase: TimeTableUseCaseType = StubTimeTableUseCase()
//    public var todoUseCase: TodoUsecaseType = StubTodoUseCase()
//}
//
//@MainActor
//extension StubHeyUseCase {
//    static public let `stub` = StubHeyUseCase()
//}
