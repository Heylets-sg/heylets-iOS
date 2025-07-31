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
    var sheetType: TimeTableSheetType? { get set }
    
    func sheet(to type: TimeTableSheetType)
}

@MainActor
public class SheetCoordinator: SheetCoordinatable, ObservableObjectSettable {
    public var objectWillChange: ObservableObjectPublisher?
    
    public var sheetType: TimeTableSheetType? = nil {
        didSet {
            notifyWillChange()
        }
    }
    
    public func sheet(to type: TimeTableSheetType) {
        self.sheetType = type
    }
}
