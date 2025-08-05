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

public final class TimeTableState: ObservableObject {
    @Published public var selectLecture: [TimeTableCellInfo] = []
    @Published public var selectedThemeColor: [String] = []
    
    public init(
        selectLecture: [TimeTableCellInfo] = [],
        selectedThemeColor: [String] = []
    ) {
        self.selectLecture = selectLecture
        self.selectedThemeColor = selectedThemeColor
    }
    
    public func selecttLecture(_ info: [TimeTableCellInfo]) {
        self.selectLecture = info
    }
    
    public func clearLecture() {
        self.selectLecture = []
    }
}

@MainActor
extension TimeTableState {
    static public let `default` = TimeTableState()
}
