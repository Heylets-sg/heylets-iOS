//
//  TimeTableSub.swift
//  DSKit
//
//  Created by 류희재 on 4/7/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

public extension Color {
    enum Filter {
        public enum Check {
            public static let buttonActive = Color(.filterCheckButtonActive)
            public static let iconActive = Color(.filterCheckIconActive)
            public static let strokeUnActivew = Color(.filterCheckStrokeUnactive)
        }
        
        public enum Stroke {
            public static let active = Color(.filterStrokeActive)
            public static let unActive = Color(.filterStrokeUnactive)
        }
        
        public enum Text {
            public static let active = Color(.filterTextActive)
            public static let unActive = Color(.filterTextUnactive)
        }
        
        public static let list = Color(.filterListDefault)
    }
    
    static var filter: Filter.Type {
        return Filter.self
    }
    
    enum Module {
        public enum Add {
            public static let button = Color(.moduleAddButtonDefault)
            public static let text = Color(.moduleAddTextDefault)
        }
        
        public static let info2 = Color(.moduleInfo2Default)
        public static let preview = Color(.modulePreview)
        public static let search = Color(.moduleSearchDefault)
        public static let select = Color(.moduleSelectDefault)
    }
    
    static var module: Module.Type {
        return Module.self
    }
    
    enum Setting {
        public static let title = Color(.infoSettingTitle)
        public static let set = Color(.infoSettingSet)
        public static let inviteBox = Color(.inviteBox)
        public static let copyButton = Color(.copyButton)
        public static let copyIcon = Color(.copyIcon)
    }
    
    static var setting: Setting.Type {
        return Setting.self
    }
    
    enum TimeTableSub {
        public static let searchDelete = Color(.searchDelete)
        public static let addCustom = Color(.addCustom)
    }
    
    static var timeTableSub: TimeTableSub.Type {
        return TimeTableSub.self
    }
}
