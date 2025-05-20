//
//  TimeTableNavigator.swift
//  TimeTableFeature
//
//  Created on 3/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import BaseFeatureDependency
import Domain
import Core

// TimeTable 내부 화면 전환을 관리하는 클래스
@MainActor
public class TimeTableNavigator {
    // 기존 NavigationRouter 참조
    private let navigationRouter: NavigationRoutableType
    
    // 화면 전환 전 상태 저장용 속성 - 디버깅 위해 변수명 변경
    private var savedViewType: TimeTableViewType?
    
    // viewType 변경 이벤트를 발행하는 Subject
    private let viewTypeSubject = PassthroughSubject<TimeTableViewType, Never>()
    
    // 외부에서 구독할 수 있는 Publisher
    public var viewTypePublisher: AnyPublisher<TimeTableViewType, Never> {
        return viewTypeSubject.eraseToAnyPublisher()
    }
    
    public init(navigationRouter: NavigationRoutableType) {
        self.navigationRouter = navigationRouter
    }
    
    // InviteCode 화면으로 이동
    public func navigateToInviteCode(from viewType: TimeTableViewType) {
        print("🚢 TimeTableNavigator: 저장된 viewType = \(viewType)")
        self.savedViewType = viewType
        navigationRouter.push(to: .inviteCode)
    }
    
    // 뒤로 가기 및 이전 viewType 복원
    public func popAndRestoreViewType() {
        print("🚢 TimeTableNavigator: 복원 시도, savedViewType = \(String(describing: savedViewType))")
        navigationRouter.pop()
        
        // 저장된 viewType이 있을 경우에만 복원
        if let viewType = savedViewType {
            print("🚢 TimeTableNavigator: viewType 복원 = \(viewType)")
            
            // UI 업데이트를 위한 딜레이 추가
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
                guard let self = self else { return }
                self.viewTypeSubject.send(viewType)
                // 사용 후 초기화하지 않음 - 디버깅을 위해
            }
        }
    }
}
