//
//  TimeTableCoordinator.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

import Core
import Domain


public typealias SheetCoordinatorType = SheetCoordinatable & ObservableObjectSettable
public typealias PresentCoordinatorType = PresentCoordinatable & ObservableObjectSettable

@MainActor
final public class TimeTableCoordinator: ObservableObject {
    public var sheetCoordinator: SheetCoordinatorType
    public var presentCoordinator: any PresentCoordinatorType
    
    public init(
        sheetCoordinator: SheetCoordinatorType,
        presentCoordinator: any PresentCoordinatorType
    ) {
        self.sheetCoordinator = sheetCoordinator
        self.presentCoordinator = presentCoordinator
        
        
        sheetCoordinator.setObjectWillChange(objectWillChange)
        presentCoordinator.setObjectWillChange(objectWillChange)
    }
}

extension TimeTableCoordinator {
    static public let `default` = TimeTableCoordinator(
        sheetCoordinator: SheetCoordinator(),
        presentCoordinator: PresentCoordinator()
    )
}
