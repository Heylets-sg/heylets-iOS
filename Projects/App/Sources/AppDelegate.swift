//
//  AppDelegate.swift
//  Heylets-iOS
//
//  Created by 류희재 on 2/17/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import FirebaseMessaging
import UIKit

@MainActor
class AppDelegate: NSObject, UIApplicationDelegate {
    
    private let firebaseManager: FirebaseManaging = FirebaseManager()
    private let notificationManager: NotificationManaging = NotificationManager()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        Task {
            firebaseManager.configure()
            await notificationManager.requestPermission()
        }
        
        return true
    }
    
    // 데이터 메시지 처리 (notification 객체가 없는 경우도 처리)
    private func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) async {
        
        await notificationManager.handleRemoteNotification(userInfo)
        completionHandler(.newData)
    }
    
    /// 백그라운드에서 푸시 알림을 탭했을 때 실행
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNS token: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
}
