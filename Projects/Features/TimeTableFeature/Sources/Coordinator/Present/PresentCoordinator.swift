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
    var viewType: TimeTableViewType { get set }
    func switchTo(_ viewType: TimeTableViewType)
    func reset()
    func isMain() -> Bool
}

public class PresentCoordinator: PresentCoordinatable, ObservableObjectSettable {
    public var objectWillChange: ObservableObjectPublisher?
    
    public var viewType: TimeTableViewType = .main {
        didSet {
            print("📌 viewType changed to \(viewType)")
            notifyWillChange()
        }
    }

    
    public func switchTo(_ viewType: TimeTableViewType) { self.viewType = viewType }
    public func reset() { self.viewType = .main }
    public func isMain() -> Bool { return viewType == .main }
}

extension PresentCoordinator {
    public var binding: Binding<TimeTableViewType> {
        Binding(
            get: { self.viewType },
            set: { self.switchTo($0) }
        )
    }
}
