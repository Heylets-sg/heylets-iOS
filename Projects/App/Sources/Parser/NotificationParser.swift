//
//  NotificationParsing.swift
//  Heylets-iOS
//
//  Created by 류희재 on 6/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

// ✅ 복잡한 파싱 로직을 별도 클래스로
protocol NotificationParsing {
    func parse(_ userInfo: [AnyHashable: Any]) -> ParsedNotification
}

struct NotificationParser: NotificationParsing {
    func parse(_ userInfo: [AnyHashable: Any]) -> ParsedNotification {
        // 🎯 여러 케이스를 체계적으로 파싱
        if let directNotification = parseDirectNotification(userInfo) {
            return directNotification
        }
        
        if let dataNotification = parseDataNotification(userInfo) {
            return dataNotification
        }
        
        return ParsedNotification(
            type: .unknown,
            action: .none,
            title: "",
            body: "",
            originalUserInfo: userInfo
        )
    }
    
    private func parseDirectNotification(_ userInfo: [AnyHashable: Any]) -> ParsedNotification? {
        guard let title = userInfo["notificationTitle"] as? String,
              let body = userInfo["notificationBody"] as? String else {
            return nil
        }
        
        let action = parseAction(from: userInfo)
        
        return ParsedNotification(
            type: .displayable,
            action: action,
            title: title,
            body: body,
            originalUserInfo: userInfo
        )
    }
    
    private func parseDataNotification(_ userInfo: [AnyHashable: Any]) -> ParsedNotification? {
        guard let data = userInfo["data"] as? [String: Any],
              let title = data["notificationTitle"] as? String,
              let body = data["notificationBody"] as? String else {
            return nil
        }
        
        let action = parseAction(from: data)
        
        return ParsedNotification(
            type: .displayable,
            action: action,
            title: title,
            body: body,
            originalUserInfo: userInfo
        )
    }
    
    private func parseAction(from data: [AnyHashable: Any]) -> NotificationAction {
        guard let actionString = data["action"] as? String else {
            return .none
        }
        
        switch actionString {
        case "OPEN_THEME_SCREEN":
            return .openTheme
        default:
            return .custom(actionString)
        }
    }
}

// 🎯 타입 안전한 알림 데이터 구조
struct ParsedNotification {
    let type: NotificationType
    let action: NotificationAction
    let title: String
    let body: String
    let originalUserInfo: [AnyHashable: Any]
}

enum NotificationType {
    case dataOnly
    case displayable
    case unknown
}

enum NotificationAction {
    case none
    case openTheme
    case custom(String)
}
