//
//  Popup.swift
//  DSKit
//
//  Created by 류희재 on 4/7/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

public extension Color {
    enum Popup {
        public static let `default` = Color(DSKitAsset.popupDefault.color)
        
        enum Text {
            public static let `default` = Color(DSKitAsset.popupTextDefault.color)
        }
        
        enum Button {
            public static let `default` = Color(DSKitAsset.popupButtonCtaDefault.color)
            public static let expect = Color(DSKitAsset.popupButtonCtaExcept.color)
        }
        
        enum Divider {
            public static let review = Color(DSKitAsset.dividerReview.color)
        }
    }
    
    static var popup: Popup.Type {
        return Popup.self
    }
}
