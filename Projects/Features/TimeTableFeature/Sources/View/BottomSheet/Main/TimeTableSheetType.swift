//
//  TimeTableSheetType.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI

enum SheetType: Identifiable {
    case reportMissingModule
    case setting
    case detail
    
    var id: String {
        switch self {
        case .reportMissingModule: return "reportMissingModule"
        case .setting: return "setting"
        case .detail: return "detail"
        }
    }
}

