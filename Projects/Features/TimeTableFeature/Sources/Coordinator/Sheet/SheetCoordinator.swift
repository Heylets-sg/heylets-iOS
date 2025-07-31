//
//  Sheet.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Core

@MainActor
public protocol SheetCoordinatable {
    var sheetView: TimeTableSheetType? { get set }
    
    func sheet(to type: TimeTableSheetType)
}

@MainActor
public class SheetCoordinator: SheetCoordinatable, ObservableObjectSettable {
    public var objectWillChange: ObservableObjectPublisher?
    
    public var sheetView: TimeTableSheetType? = nil {
        didSet {
            notifyWillChange()
        }
    }
    
    nonisolated public func sheet(to type: TimeTableSheetType) {
        Task { @MainActor in
            self.sheetView = sheetView
        }
    }
}
