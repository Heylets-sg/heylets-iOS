//
//  TimeTableViewTypeService.swift
//  TimeTableFeature
//
//  Created on 3/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

public protocol TimeTableViewTypeServiceType: ObservableObject {
    var viewType: TimeTableViewType { get }
    func switchTo(_ viewType: TimeTableViewType)
    func reset()
}

public class TimeTableViewTypeService: TimeTableViewTypeServiceType {
    // Singleton instance
    public static let shared = TimeTableViewTypeService()
    
    @Published public private(set) var viewType: TimeTableViewType = .main
    private let notificationCenter: NotificationCenter
    
    // Private initializer for singleton
    private init(notificationCenter: NotificationCenter = .default) {
        self.notificationCenter = notificationCenter
    }
    
    public func switchTo(_ viewType: TimeTableViewType) {
        self.viewType = viewType
        // Broadcast change via Notification Center to allow any component to listen
        notificationCenter.post(
            name: .timeTableViewTypeChanged,
            object: nil,
            userInfo: ["viewType": viewType.rawValue]
        )
    }
    
    public func reset() {
        self.viewType = .main
    }
}

// For preview and testing
public class StubTimeTableViewTypeService: TimeTableViewTypeServiceType {
    @Published public private(set) var viewType: TimeTableViewType = .main
    
    public init(initialViewType: TimeTableViewType = .main) {
        self.viewType = initialViewType
    }
    
    public func switchTo(_ viewType: TimeTableViewType) {
        self.viewType = viewType
    }
    
    public func reset() {
        self.viewType = .main
    }
}

// Add a helper to create a binding that updates the service
extension TimeTableViewTypeServiceType {
    public var binding: Binding<TimeTableViewType> {
        Binding(
            get: { self.viewType },
            set: { self.switchTo($0) }
        )
    }
}
