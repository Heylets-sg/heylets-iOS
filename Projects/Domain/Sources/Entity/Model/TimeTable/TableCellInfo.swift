//
//  TableCellInfo.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import SwiftUI

public struct TimeTableCellInfo: Equatable, Hashable {
    public var id: Int
    public var code: String
    public var name: String
    public var professor: String
    public var unit: Int?
    public var schedule: ScheduleInfo
    public var backgroundColor: Color
    public var textColor: Color
}
