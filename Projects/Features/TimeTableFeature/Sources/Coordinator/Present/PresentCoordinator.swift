//
//  PresentCoordinator.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//
import Foundation
import Combine

import Core
import SwiftUI

@MainActor
public protocol PresentCoordinatable: ObservableObject {
    var viewType: TimeTableViewType { get }
    func switchTo(_ viewType: TimeTableViewType)
    func reset()
}

public class PresentCoordinator: PresentCoordinatable, ObservableObjectSettable {
    public var objectWillChange: ObservableObjectPublisher?
    
    @Published public private(set) var viewType: TimeTableViewType = .main {
        didSet {
            notifyWillChange()
        }
    }

    
    public func switchTo(_ viewType: TimeTableViewType) {
        self.viewType = viewType
    }
    
    public func reset() {
        self.viewType = .main
    }
}

extension PresentCoordinator {
    public var binding: Binding<TimeTableViewType> {
        Binding(
            get: { self.viewType },
            set: { self.switchTo($0) }
        )
    }
}
