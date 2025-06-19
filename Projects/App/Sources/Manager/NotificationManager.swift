//
//  NotificationManager.swift
//  Heylets-iOS
//
//  Created by 류희재 on 6/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import UIKit
import UserNotifications

@MainActor
protocol NotificationManaging {
    func requestPermission() async
//    func handleRemoteNotification(_ userInfo: [AnyHashable: Any])
//    func handleNotificationTap(_ response: UNNotificationResponse)
}


final class NotificationManager: NSObject, NotificationManaging {
    func requestPermission() async {
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: authOptions)
            if granted {
                // UNUserNotificationCenterDelegate를 구현한 메서드를 실행시킴
                UIApplication.shared.registerForRemoteNotifications()
            }
        } catch {
            print("🔕 알림 권한 요청 실패: \(error)")
        }
    }

}
