//
//  WindowRoutable.swift
//  BaseFeatureDependency
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

@MainActor
public protocol WindowRoutable {
    var destination: WindowDestination { get }
    func getDestination() -> WindowDestination
    nonisolated func `switch`(to destination: WindowDestination)
    nonisolated func goBack()
}

@MainActor
final public class WindowRouter: WindowRoutable, ObservableObjectSettable {
    
    public init() {}
    
    public var objectWillChange: ObservableObjectPublisher?
    
    private var history: [WindowDestination] = [.splash]
    
    @Published public var destination: WindowDestination = .splash {
        didSet {
            notifyWillChange()
        }
    }
    
    nonisolated public func `switch`(to destination: WindowDestination) {
        Task { @MainActor in
            if self.destination != destination {
                history.append(self.destination)
            }
            
            Analytics.shared.track(.screenView(destination.screenName, .screen))
            self.destination = destination
        }
        
    }
    
    nonisolated public func goBack() {
        Task { @MainActor in
            // 히스토리가 비어있으면 이동할 수 없음
            guard !history.isEmpty else { return }
            
            // 히스토리에서 마지막 화면을 가져옴
            let previousDestination = history.removeLast()
            
            // 이전 화면으로 이동
            Analytics.shared.track(.screenView(previousDestination.screenName, .screen))
            self.destination = previousDestination
        }
        
    }
    
    /// 특정 화면까지 뒤로 이동하는 함수
    /// - Parameter destination: 이동하려는 목적지
    /// - Returns: 이동 성공 여부
    public func goBackTo(destination: WindowDestination) -> Bool {
        // 히스토리에서 해당 목적지의 인덱스를 찾음
        guard let index = history.lastIndex(of: destination) else {
            return false
        }
        
        // 해당 인덱스까지의 히스토리 유지
        history = Array(history.prefix(through: index))
        
        // 이전 화면으로 이동
        let previousDestination = history.removeLast()
        Analytics.shared.track(.screenView(previousDestination.screenName, .screen))
        self.destination = previousDestination
        
        return true
    }
    
    /// 히스토리 초기화 함수
    public func resetHistory() {
        history = [.splash]
    }
    
    public func getDestination() -> WindowDestination {
        return destination
    }
}

