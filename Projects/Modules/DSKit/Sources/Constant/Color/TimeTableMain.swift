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
        
            public static let bottomSheet = Color(.bottomsheetDefault)
            
            public static let tabNavigator = Color(.tabNavigatorDefault)
            
            public enum Day {
                public static let dayInfo = Color(.dayInfoDefault)
                public static let dayInfobox = Color(.dayInfoboxDefault)
            }
            
            public enum ModuleInfo {
                public static let info = Color(.moduleInfoDefault)
                public static let delete = Color(.moduleDeleteDefault)
            }
            
            public enum Navigator {
                public static let iconActive = Color(.navigatorIconActive)
                public static let iconUnActive = Color(.navigatorIconUnactive)
            }
            
            public enum Timeline {
                public static let `default` = Color(.timelineDefault)
                public static let background = Color(.timelineBackgroundDefault)
            }
            
            public enum TimeTableInfo {
                public static let semester = Color(.semesterInfoDefault)
                public static let tableName = Color(.timetableNameDefault)
                public static let topIcon = Color(.topIconDefault)
                public static let topNavi = Color(.topNaviDefault)
            }
        }
        
    
    static var timeTableMain: TimeTableMain.Type {
        return TimeTableMain.self
    }
}
