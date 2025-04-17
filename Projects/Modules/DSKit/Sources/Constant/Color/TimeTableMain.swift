//
//  TimeTable.swift
//  DSKit
//
//  Created by 류희재 on 4/7/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

public extension Color {
    
    enum TimeTableMain {
        
            public static let bottomSheet = Color(DSKitAsset.bottomsheetDefault.color)
            
            public static let tabNavigator = Color(DSKitAsset.tabNavigatorDefault.color)
            
            public enum Day {
                public static let dayInfo = Color(DSKitAsset.dayInfoDefault.color)
                public static let dayInfobox = Color(DSKitAsset.dayInfoboxDefault.color)
            }
            
            public enum ModuleInfo {
                public static let info = Color(DSKitAsset.moduleInfoDefault.color)
                public static let delete = Color(DSKitAsset.moduleDeleteDefault.color)
            }
            
            public enum Navigator {
                public static let iconActive = Color(DSKitAsset.navigatorIconActive.color)
                public static let iconUnActive = Color(DSKitAsset.navigatorIconUnactive.color)
            }
            
            public enum Timeline {
                public static let `default` = Color(DSKitAsset.timelineDefault.color)
                public static let background = Color(DSKitAsset.timelineBackgroundDefault.color)
            }
            
            public enum TimeTableInfo {
                public static let semester = Color(DSKitAsset.semesterInfoDefault.color)
                public static let tableName = Color(DSKitAsset.timetableNameDefault.color)
                public static let topIcon = Color(DSKitAsset.topIconDefault.color)
                public static let topNavi = Color(DSKitAsset.topNaviDefault.color)
            }
        }
        
    
    static var timeTableMain: TimeTableMain.Type {
        return TimeTableMain.self
    }
}
