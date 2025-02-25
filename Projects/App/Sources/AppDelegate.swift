////
////  AppDelegate.swift
////  Heylets-iOS
////
////  Created by 류희재 on 2/17/25.
////  Copyright © 2025 Heylets-iOS. All rights reserved.
////
//
//
//import Foundation
//import UserNotifications
//import ThirdPartyLibs
//import FirebaseCore
//import FirebaseMessaging
//import UIKit
//import Networks
//
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        
//        // 파이어베이스 설정
//        FirebaseApp.configure()
//        
//        // 앱 실행 시 사용자에게 알림 허용 권한을 받음
//        UNUserNotificationCenter.current().delegate = self
//        
//        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound] // 필요한 알림 권한을 설정
//        UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: { _, _ in }
//        )
//        
//        // UNUserNotificationCenterDelegate를 구현한 메서드를 실행시킴
//        application.registerForRemoteNotifications()
//        
//        // 파이어베이스 Meesaging 설정
//        Messaging.messaging().delegate = self
//        
//        return true
//    }
//}
//
//extension AppDelegate: UNUserNotificationCenterDelegate {
//    
//    // 백그라운드에서 푸시 알림을 탭했을 때 실행
//    func application(_ application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        print("APNS token: \(deviceToken)")
//        Messaging.messaging().apnsToken = deviceToken
//    }
//    
//    // Foreground(앱 켜진 상태)에서도 알림 오는 설정
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.list, .banner])
//    }
//}
//
//extension AppDelegate: MessagingDelegate {
//    
//    // 파이어베이스 MessagingDelegate 설정
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//      print("Firebase registration token: \(String(describing: fcmToken))")
//        guard let fcmToken else { return }
//        UserDefaultsManager.setFCMTokne(fcmToken)
//      
//      // TODO: If necessary send token to application server.
//      // Note: This callback is fired at each app startup and whenever a new token is generated.
//    }
//}

import Foundation
import UserNotifications
import FirebaseCore
import FirebaseMessaging
import UIKit
import Networks

class AppDelegate: NSObject, UIApplicationDelegate {
    
    // 앱이 시작될 때 호출되는 메서드
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Firebase 초기화
        FirebaseApp.configure()
        
        // UNUserNotificationCenterDelegate 설정
        UNUserNotificationCenter.current().delegate = self
        
        // 알림 권한 요청
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        DispatchQueue.main.async {
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: { _, _ in }
            )
        }
        
        // 푸시 알림 등록
        application.registerForRemoteNotifications()
        
        // Firebase Messaging Delegate 설정
        Messaging.messaging().delegate = self
        
        return true
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 백그라운드에서 푸시 알림을 탭했을 때 실행
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("APNS token: \(deviceToken)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    // 앱이 포그라운드일 때 푸시 알림을 받았을 때 처리
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                 willPresent notification: UNNotification,
                                 withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 알림을 화면에 표시
//        completionHandler([.alert, .badge, .sound])
    }
}

extension AppDelegate: MessagingDelegate {
    
    // Firebase Messaging에서 FCM 토큰을 받은 후 처리
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("Firebase registration token: \(String(describing: fcmToken))")
        
        // FCM 토큰이 nil이 아니면 저장
        guard let fcmToken = fcmToken else { return }
        UserDefaultsManager.setFCMTokne(fcmToken)
    }
}
