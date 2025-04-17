//
//  Mypage.swift
//  DSKit
//
//  Created by 류희재 on 4/7/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

public extension Color {
    enum Mypage {
        public static let menubox = Color(DSKitAsset.menuBoxDefault.color)
    }
    
    static var mypage: Mypage.Type {
        return Mypage.self
    }
    
    enum Toggle {
        public static let `default` = Color(DSKitAsset.toggleDefault.color)
        public static let swtich = Color(DSKitAsset.toggleSwitchDefault.color)
    }
    
    static var toggle: Toggle.Type {
        return Toggle.self
    }
}
