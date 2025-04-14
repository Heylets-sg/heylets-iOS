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
            completionHandler: { _, _ in }
        )
        
        // UNUserNotificationCenterDelegate를 구현한 메서드를 실행시킴
        application.registerForRemoteNotifications()
        
        // 파이어베이스 Messaging 설정
        Messaging.messaging().delegate = self
        
        // FCM 토큰 확인
        Messaging.messaging().token { token, error in
            if let error = error {
                print("FCM 토큰 에러: \(error)")
            } else if let token = token {
                print("FCM 초기 토큰: \(token)")
                UserDefaultsManager.setFCMTokne(token)
            }
        }
        
//        Analytics.shared.track(.appStart)
        
        return true
    }
    
    // 데이터 메시지 처리
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("Received remote notification: \(userInfo)")
        
        // 데이터 메시지의 notificationTitle과 notificationBody를 사용하여 로컬 알림 생성
        if let notificationTitle = userInfo["notificationTitle"] as? String,
           let notificationBody = userInfo["notificationBody"] as? String {
            
            let content = UNMutableNotificationContent()
            content.title = notificationTitle
            content.body = notificationBody
            
            // 데이터도 같이 전달
            content.userInfo = userInfo
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request) { error in
                if let error = error {
                    print("Error adding notification: \(error)")
                }
            }
        }
        
        completionHandler(.newData)
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
    
    // 사용자가 알림을 탭했을 때 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        print("Notification tapped: \(userInfo)")
        
        // action 값에 따라 화면 이동 처리
        if let action = userInfo["action"] as? String {
            NotificationCenter.default.post(name: NSNotification.Name("HandleNotificationAction"), object: nil, userInfo: ["action": action, "data": userInfo])
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
            
            // 필요한 경우 여기에 서버에 토큰 등록 로직 추가
            // sendTokenToServer(fcmToken)
        }
    }
}
