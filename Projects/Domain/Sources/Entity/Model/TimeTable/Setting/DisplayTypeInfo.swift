//
//  DisplayTypeInfo'.swift
//  Domain
//
//  Created by 류희재 on 1/22/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public enum DisplayTypeInfo: String, CaseIterable {
    case MODULE_CODE
    case MODULE_CODE_CLASSROOM
    case MODULE_CODE_CLASSROOM_CREDIT
    case MODULE_CODE_CREDIT
    
    public var text: String {
        switch self {
        case .MODULE_CODE:
            "module code"
        case .MODULE_CODE_CLASSROOM:
            "module code, class room"
        case .MODULE_CODE_CLASSROOM_CREDIT:
            "module code, class room, unit"
        case .MODULE_CODE_CREDIT:
            "module code, unit"
        }
    }
    
    public var classRoomIsVisible: Bool {
        switch self {
        case .MODULE_CODE, .MODULE_CODE_CREDIT:
            return false
        case .MODULE_CODE_CLASSROOM, .MODULE_CODE_CLASSROOM_CREDIT:
            return true
        }
    }
    
    public var creditIsVisible: Bool {
        switch self {
        case .MODULE_CODE, .MODULE_CODE_CLASSROOM:
            return false
        case .MODULE_CODE_CLASSROOM_CREDIT, .MODULE_CODE_CREDIT:
            return true
        }
    }
}


extension DisplayTypeInfo {
    static public func toEntity(with type: String) -> DisplayTypeInfo {
        switch type {
        case "MODULE_CODE":
            return .MODULE_CODE
        case "MODULE_CODE_CLASSROOM":
            return .MODULE_CODE_CLASSROOM
        case "MODULE_CODE_CLASSROOM_CREDIT":
            return .MODULE_CODE_CLASSROOM_CREDIT
        case "MODULE_CODE_CREDIT":
            return .MODULE_CODE_CREDIT
        default:
            fatalError("Unsupported type: \(type)")
        }
    }
}
