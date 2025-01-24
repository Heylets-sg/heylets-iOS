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
    var onboardingUseCase: OnboardingUseCaseType { get }
    var timeTableUseCase: TimeTableUseCaseType { get }
    var splashUseCase: SplashUseCaseType { get }
}

public final class HeyUseCase: UseCaseType {
    
    var repository: RepositoryType
    
    public var splashUseCase: SplashUseCaseType
    public var myPageUseCase: MyPageUseCaseType
    public var onboardingUseCase: OnboardingUseCaseType
    public var timeTableUseCase: TimeTableUseCaseType
    
    public init(repository: RepositoryType) {
        self.repository = repository
        
        splashUseCase = SplashUseCase(
            authRepository: repository.authRepository
        )
        
        myPageUseCase = MyPageUseCase(
            userRepository: repository.userRepository,
            authRepository: repository.authRepository
        )
        
        onboardingUseCase = OnboardingUseCase(
            authRepository: repository.authRepository
        )
        
        timeTableUseCase = TimeTableUseCase(
            userRepository: repository.userRepository,
            lectureRepository: repository.lectureRepository,
            scheduleRepository: repository.scheduleRepository,
            sectionRepository: repository.sectionRepository,
            settingRepository: repository.settingRepository,
            timeTableRepository: repository.timeTableRepository
        
        )
    }
}

public final class StubHeyUseCase: UseCaseType {
    public init() {}
    
    public var splashUseCase: SplashUseCaseType = StubSplashUseCase()
    public var myPageUseCase: MyPageUseCaseType = StubMyPageUseCase()
    public var onboardingUseCase: OnboardingUseCaseType = StubOnboardingUseCase()
    public var timeTableUseCase: TimeTableUseCaseType = StubTimeTableUseCase()
}

extension StubHeyUseCase {
    static public let `stub` = StubHeyUseCase()
}
