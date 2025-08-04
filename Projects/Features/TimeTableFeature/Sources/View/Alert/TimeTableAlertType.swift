//
//  TimeTableAlertType.swift
//  TimeTableFeature
//
//  Created by 류희재 on 7/31/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import DSKit

public enum HeyTimeTableAlertType {
    case deleteAlert
    case error(String)
    case emptyScheduleError(String)
    
    var title: String {
        switch self {
        case .deleteAlert: return "Delete module?"
        case .error(let title): return title
        case .emptyScheduleError: return "The section hasn't been registered yet"
        }
    }
    
    var primaryAction: TimeTableAlertAction {
        switch self {
        case .deleteAlert:
            return TimeTableAlertAction(
                title: "Delete",
                style: .error,
                action: .deleteModule
            )
        case .error:
            return TimeTableAlertAction(
                title: "Close",
                style: .gray,
                action: .errorAlertViewCloseButtonDidTap
            )
        case .emptyScheduleError(let name):
            return TimeTableAlertAction(
                title: "Add",
                style: .gray,
                action: .emptyScheduleErrorAddButtonDidTap(name)
            )
        }
    }
    
    var secondaryAction: TimeTableAlertAction? {
        switch self {
        case .deleteAlert:
            return TimeTableAlertAction(
                title: "Close",
                style: .gray,
                action: .deleteModuleAlertCloseButtonDidTap
            )
        default:
            return nil
        }
    }
}

public struct TimeTableAlertAction {
    let title: String
    let style: HeyAlertButtonColorStyle
    let action: MainViewModel.AlertAction
    
    @MainActor
    func convert(on viewModel: MainViewModel) -> HeyAlertButtonType {
        return (title: title, style: style, { viewModel.send(action) })
    }
}
