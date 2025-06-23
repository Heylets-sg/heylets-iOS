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

@MainActor
public protocol TimeTableViewTypeServiceType: ObservableObject {
    var viewType: TimeTableViewType { get }
    func switchTo(_ viewType: TimeTableViewType)
    func reset()
}

public class TimeTableViewTypeService: TimeTableViewTypeServiceType {
    public static let shared = TimeTableViewTypeService()
    
    @Published public private(set) var viewType: TimeTableViewType = .main
    
    public func switchTo(_ viewType: TimeTableViewType) {
        self.viewType = viewType
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

extension TimeTableViewTypeServiceType {
    public var binding: Binding<TimeTableViewType> {
        Binding(
            get: { self.viewType },
            set: { self.switchTo($0) }
        )
    }
}
