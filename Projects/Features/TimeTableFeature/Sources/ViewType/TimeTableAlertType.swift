//
//  TimeTableAlertType.swift
//  TimeTableFeature
//
//  Created by 류희재 on 4/21/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
enum TimeTableAlertType {
    case deleteLecture(sectionId: Int, isCustom: Bool)
    case reportMissingModule
    case addCustom
    case guestError
    case emptyScheduleError(String)
    case selectInfoView
    
    var title: String {
        switch self {
        case .deleteLecture:
            return "Delete Module"
        case .reportMissingModule:
            return "Missing Module"
        case .addCustom:
            return "Add Custom Module"
        case .guestError:
            return "Guest Mode Limitations"
        case .emptyScheduleError:
            return "Empty Schedule"
        case .selectInfoView:
            return "Module Information"
        }
    }
    
    var message: String {
        switch self {
        case .deleteLecture:
            return "Are you sure you want to delete this module?"
        case .reportMissingModule:
            return "Would you like to report a missing module?"
        case .addCustom:
            return "You can add a custom module here."
        case .guestError:
            return "This feature is not available in guest mode. Would you like to convert to a full account?"
        case .emptyScheduleError(let message):
            return message
        case .selectInfoView:
            return "You can view module details or information."
        }
    }
    
    var primaryButtonTitle: String {
        switch self {
        case .deleteLecture:
            return "Delete"
        case .reportMissingModule:
            return "Report"
        case .addCustom:
            return "Add"
        case .guestError:
            return "Sign Up"
        case .emptyScheduleError:
            return "OK"
        case .selectInfoView:
            return "View Details"
        }
    }
    
    var secondaryButtonTitle: String? {
        switch self {
        case .deleteLecture, .reportMissingModule, .guestError:
            return "Cancel"
        case .addCustom:
            return "Back"
        case .emptyScheduleError, .selectInfoView:
            return nil
        }
    }
    
    var isPrimaryDestructive: Bool {
        switch self {
        case .deleteLecture:
            return true
        default:
            return false
        }
    }
}
