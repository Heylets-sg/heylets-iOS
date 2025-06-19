//
//  NotificationManager.swift
//  Heylets-iOS
//
//  Created by 류희재 on 6/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import UIKit
import UserNotifications
import BaseFeatureDependency
import TimeTableFeature
import FirebaseMessaging

@MainActor
protocol NotificationManaging {
    func requestPermission() async
    func handleRemoteNotification(_ userInfo: [AnyHashable: Any]) async
    func handleNotificationTap(_ response: UNNotificationResponse) async
}


final class NotificationManager: NSObject, NotificationManaging {
    private let parser: NotificationParsing
    
    init(_ parser: NotificationParser = NotificationParser()) {
        self.parser = parser
        super.init()
        setupNotificationCenter()
    }
    
    /// 앱 실행 시 사용자에게 알림 허용 권한을 받음
    private func setupNotificationCenter() {
        UNUserNotificationCenter.current().delegate = self
    }
    
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
    
    func handleRemoteNotification(_ userInfo: [AnyHashable: Any]) async {
        let notification = parser.parse(userInfo)
        
        switch notification.type {
        case .dataOnly:
            await handleAction(notification.action)
        case .displayable:
            await createLocalNotification(from: notification)
        case .unknown:
            break
        }
    }
    
}

extension NotificationManager: @preconcurrency UNUserNotificationCenterDelegate {
    /// Foreground(앱 켜진 상태)에서도 알림 오는 설정
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
    ) {
        completionHandler([.banner, .list, .sound])
    }
    
    /// 사용자가 알림을 탭했을 때 처리
    func userNotificationCenter(
        _ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void
    ) {
        Task {
            await self.handleNotificationTap(response)
            completionHandler()
        }
    }
    
    @MainActor
    func handleNotificationTap(_ response: UNNotificationResponse) async {
        let userInfo = response.notification.request.content.userInfo
        let notification = parser.parse(userInfo)
        await handleAction(notification.action)
    }
}

extension NotificationManager {
    /// 로컬 알림 생성 함수
    private func createLocalNotification(from notification: ParsedNotification) async {
        let content = UNMutableNotificationContent()
        content.title = notification.title
        content.body = notification.body
        content.sound = .default
        content.userInfo = notification.originalUserInfo // 원본 데이터 보존
        
        // 즉시 표시되는 트리거
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        // 알림 요청 생성
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        await MainActor.run {
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("🔕 로컬 알림 요청 실패 ❌: \(error.localizedDescription)")
                } else {
                    print("🔔 로컬 알림 요청 성공 ✅")
                }
            }
        }
    }
    
    private func handleAction(_ action: NotificationAction) async {
        switch action {
        case .openTheme:
            Router.default.windowRouter.switch(to: .timetable)
            try? await Task.sleep(nanoseconds: 500_000_000)
            TimeTableViewTypeService.shared.switchTo(.theme(true))
        default:
            print("알 수 없는 알림 액션: \(action)")
        }
    }
}
