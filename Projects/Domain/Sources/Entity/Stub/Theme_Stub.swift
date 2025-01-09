//
//  Theme_Stub.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

extension Theme {
    static public var 라일락: Self {
        Theme(
            colorList: ["#F9F2F7", "#F9E2F9", "#FCD3F9", "#EBC9F9"],
            name: "LILAC")
    }
    
    static public var 오트: Self {
        Theme(
            colorList: ["#F6F5F1", "#EEEAE2", "#E4E0DB", "#C8C2BD"],
            name: "OAT")
    }
    
    static public var 에버그린: Self {
        Theme(
            colorList: ["#E5EEED", "#C9D5D1", "#ACC3BD", "#6E918D"],
            name: "EVERGREEN")
    }
    
    static public var 베이비블루: Self {
        Theme(
            colorList: ["#F7FBFC", "#D6E6F2", "#B9D7EA", "#A2C7DE"],
            name: "BABY_BLUE")
    }
    
    static public var 베이지: Self {
        Theme(
            colorList: ["#EEEBE6", "#E3D8CA", "#E8D9C6", "#CDB199"],
            name: "BEIGE")
    }    
}

