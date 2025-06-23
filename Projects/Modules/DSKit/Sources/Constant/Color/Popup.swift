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
        public static let `default` = Color(.popupDefault)
        
        enum Text {
            public static let `default` = Color(.popupTextDefault)
        }
        
        enum Button {
            public static let `default` = Color(.popupButtonCtaDefault)
            public static let expect = Color(.popupButtonCtaExcept)
        }
        
        enum Divider {
            public static let review = Color(.dividerReview)
        }
    }
    
    static var popup: Popup.Type {
        return Popup.self
    }
}
