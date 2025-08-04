//
//  TimeTableState.swift
//  TimeTableFeature
//
//  Created by 류희재 on 8/1/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit
import Core


public class TimeTableState: ObservableObject, ObservableObjectSettable {
    public var objectWillChange: ObservableObjectPublisher?
    
    public var selectLecture: [TimeTableCellInfo] = []  {
        didSet {
            notifyWillChange()
        }
    }
    public var selectedThemeColor: [String] = [] {
        didSet {
            notifyWillChange()
        }
    }
    
    public init(
        selectLecture: [TimeTableCellInfo] = [],
        selectedThemeColor: [String] = []
    ) {
        self.selectLecture = selectLecture
        self.selectedThemeColor = selectedThemeColor
        
        self.setObjectWillChange(objectWillChange)
    }
    
    func setLecture(_ info: [TimeTableCellInfo]) {
        self.selectLecture = info
    }
}

extension TimeTableState {
    static public let `default` = TimeTableState()
}

