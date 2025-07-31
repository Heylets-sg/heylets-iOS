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
public protocol TimeTableTransitionHandlerType: ObservableObject {
    var sheetType: TimeTableSheetType? { get }
    var viewType: TimeTableViewType { get }
    func switchTo(_ viewType: TimeTableViewType)
    func sheetTo(_ sheetType: TimeTableSheetType)
    func reset()
}

public class TransitionHandler: TimeTableTransitionHandlerType {
    @Published public private(set) var viewType: TimeTableViewType = .main
    @Published public private(set) var sheetType: TimeTableSheetType? = nil
    
    public func switchTo(_ viewType: TimeTableViewType) {
        self.viewType = viewType
    }
    
    public func sheetTo(_ viewType: TimeTableSheetType) {
        self.sheetType = sheetType
    }
    
    public func reset() {
        self.viewType = .main
    }
}

extension TimeTableTransitionHandler {
    public var binding: Binding<TimeTableViewType> {
        Binding(
            get: { self.viewType },
            set: { self.switchTo($0) }
        )
    }
}
