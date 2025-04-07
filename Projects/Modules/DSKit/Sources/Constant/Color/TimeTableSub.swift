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
            public static let buttonActive = Color(DSKitAsset.filterCheckButtonActive.color)
            public static let iconActive = Color(DSKitAsset.filterCheckIconActive.color)
            public static let strokeUnActivew = Color(DSKitAsset.filterCheckStrokeUnactive.color)
        }
        
        public enum Stroke {
            public static let active = Color(DSKitAsset.filterStrokeActive.color)
            public static let unActive = Color(DSKitAsset.filterStrokeUnactive.color)
        }
        
        public enum Text {
            public static let active = Color(DSKitAsset.filterTextActive.color)
            public static let unActive = Color(DSKitAsset.filterTextUnactive.color)
        }
        
        public static let list = Color(DSKitAsset.filterListDefault.color)
    }
    
    static var filter: Filter.Type {
        return Filter.self
    }
    
    enum Module {
        public enum Add {
            public static let button = Color(DSKitAsset.moduleAddButtonDefault.color)
            public static let text = Color(DSKitAsset.moduleAddTextDefault.color)
        }
        
        public static let info2 = Color(DSKitAsset.moduleInfo2Default.color)
        public static let preview = Color(DSKitAsset.modulePreview.color)
        public static let search = Color(DSKitAsset.moduleSearchDefault.color)
        public static let select = Color(DSKitAsset.moduleSelectDefault.color)
    }
    
    static var module: Module.Type {
        return Module.self
    }
    
    enum TimeTableSub {
        public static let searchDelete = Color(DSKitAsset.searchDelete.color)
        public static let addCustom = Color(DSKitAsset.addCustom.color)
    }
    
    static var timeTableSub: TimeTableSub.Type {
        return TimeTableSub.self
    }
    
//    enum Setting {
//        public static let title = Color(DSKitAsset.searchDelete.color)
//        public static let set = Color(DSKitAsset.addCustom.color)
//    }
}

