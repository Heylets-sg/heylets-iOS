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
        public static let menubox = Color(.menuBoxDefault)
    }
    
    static var mypage: Mypage.Type {
        return Mypage.self
    }
    
    enum Toggle {
        public static let `default` = Color(.toggleDefault)
        public static let swtich = Color(.toggleSwitchDefault)
    }
    
    static var toggle: Toggle.Type {
        return Toggle.self
    }
}
