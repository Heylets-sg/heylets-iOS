//
//  AppDelegate.swift
//  Heylets-iOS
//
//  Created by 류희재 on 2/17/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import ThirdPartyLibs
import FirebaseMessaging
import UserNotifications
import Networks
import UIKit
import FirebaseCore
import Core
import TimeTableFeature
import BaseFeatureDependency

@MainActor
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // 파이어베이스 설정
        FirebaseApp.configure()
        
        // 앱 실행 시 사용자에게 알림 허용 권한을 받음
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { granted, error in
                if granted {
                    print("알림 권한 획득 성공")
                } else {
                    print("알림 권한 획득 실패: \(String(describing: error))")
                }
            }
        )
        
        // UNUserNotificationCenterDelegate를 구현한 메서드를 실행시킴
        application.registerForRemoteNotifications()
        
        // 파이어베이스 Messaging 설정
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true // 백그라운드 콘텐츠 가용성 활성화
        
        // FCM 토큰 확인
        Messaging.messaging().token { token, error in
            if let error = error {
                print("FCM 토큰 에러: \(error)")
            } else if let token = token {
                print("FCM 초기 토큰: \(token)")
                UserDefaultsManager.setFCMTokne(token)
            }
        }
        
        // 알림 처리 옵저버 설정
        setupNotificationHandling()
        
        return true
    }
    
    // 알림 처리를 위한 옵저버 설정
    private func setupNotificationHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(handleNotificationActionReceived),
            name: NSNotification.Name("HandleNotificationAction"),
            object: nil
        )
    }
    
    @objc private func handleNotificationActionReceived(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
              let action = userInfo["action"] as? String else {
            return
        }
        
        handleNotificationAction(action: action, userInfo: userInfo)
    }
    
    private func handleNotificationAction(action: String, userInfo: [AnyHashable: Any]) {
        switch action {
        case "OPEN_THEME_SCREEN":
            // 메인 스레드에서 실행
            DispatchQueue.main.async {
                // 여기서는 싱글톤 또는 공유 인스턴스를 사용해 접근
                Router.default.windowRouter.switch(to: .timetable)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    TimeTableViewTypeService.shared.switchTo(.theme(true))
                }
            }
        default:
            print("알 수 없는 알림 액션: \(action)")
        }
    }
    
    // 데이터 메시지 처리 (notification 객체가 없는 경우도 처리)
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Received remote notification: \(userInfo)")
        
        // 데이터 메시지 처리 로직 강화
        var notificationTitle: String?
        var notificationBody: String?
        var actionData: [String: Any]?
        
        // 1. 최상위 레벨에서 직접 데이터 확인
        if let title = userInfo["notificationTitle"] as? String,
           let body = userInfo["notificationBody"] as? String {
            notificationTitle = title
            notificationBody = body
            actionData = userInfo as? [String: Any]
        }
        
        // 2. 'data' 객체 내부 확인
        else if let data = userInfo["data"] as? [String: Any],
                let title = data["notificationTitle"] as? String,
                let body = data["notificationBody"] as? String {
            notificationTitle = title
            notificationBody = body
            actionData = data
        }
        
        // 알림 정보가 있으면 로컬 알림 생성
        if let title = notificationTitle, let body = notificationBody {
            createLocalNotification(title: title, body: body, userInfo: userInfo)
        }
        
        // 액션 데이터가 있으면 액션 처리
        if let actionData = actionData, let action = actionData["action"] as? String {
            DispatchQueue.main.async {
                self.handleNotificationAction(action: action, userInfo: ["action": action, "data": actionData])
            }
        }
        
        completionHandler(.newData)
    }
    
    // 로컬 알림 생성 함수
    private func createLocalNotification(title: String, body: String, userInfo: [AnyHashable: Any]) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        content.sound = .default
        content.userInfo = userInfo // 원본 데이터 보존
        
        // 즉시 표시되는 트리거
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 0.1, repeats: false)
        
        // 알림 요청 생성
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,
            content: content,
            trigger: trigger
        )
        
        // 알림 요청 추가
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error adding local notification: \(error)")
            }
        }
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 백그라운드에서 푸시 알림을 탭했을 때 실행
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNS token: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // iOS 14 이상에서는 .banner, .list, .sound 사용
        if #available(iOS 14.0, *) {
            completionHandler([.banner, .list, .sound])
        } else {
            // iOS 14 미만에서는 .alert 사용
            completionHandler([.alert, .sound])
        }
    }
    
    // 사용자가 알림을 탭했을 때 처리 - 개선된 로직
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("Notification tapped: \(userInfo)")
        
        // 데이터 객체 가져오기
        var actionData: [String: Any]? = nil
        var action: String? = nil
        
        // 1. 직접 'action' 키 확인
        if let actionValue = userInfo["action"] as? String {
            action = actionValue
            actionData = userInfo as? [String: Any]
        }
        
        // 2. 'data' 객체 내부 확인
        else if let data = userInfo["data"] as? [String: Any],
                let actionValue = data["action"] as? String {
            action = actionValue
            actionData = data
        }
        
        // 액션 처리
        if let action = action, let actionData = actionData {
            NotificationCenter.default.post(
                name: NSNotification.Name("HandleNotificationAction"),
                object: nil,
                userInfo: ["action": action, "data": actionData]
            )
        }
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    
    // 파이어베이스 MessagingDelegate 설정
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("FCM 토큰 갱신: \(String(describing: fcmToken))")

        guard let fcmToken = fcmToken else { return }
        
        DispatchQueue.main.async {
            UserDefaultsManager.setFCMTokne(fcmToken)
        }
    }
}
