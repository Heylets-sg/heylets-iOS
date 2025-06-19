//
//  FirebaseManager.swift
//  Heylets-iOS
//
//  Created by 류희재 on 6/19/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import FirebaseMessaging
import FirebaseCore
import Networks
import Foundation

@MainActor
protocol FirebaseManaging {
    func configure()
    func getFCMToken()
}

final class FirebaseManager: NSObject, FirebaseManaging {
    func configure() {
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        Messaging.messaging().isAutoInitEnabled = true
        
        print("✅ Firebase 설정 완료")
    }
    
    func getFCMToken() {
        return Messaging.messaging().token { token, error in
            if let error = error {
                print("FCM 토큰 에러: \(error)")
            } else if let token = token {
                print("FCM 초기 토큰: \(token)")
                UserDefaultsManager.setFCMTokne(token)
            }
        }
    }
}

// MARK: - MessagingDelegate
extension FirebaseManager: MessagingDelegate {
    /// FCM 토큰 갱신 이벤트를 처리하기 위한 delegate 메서드
    nonisolated public func messaging(
        _ messaging: Messaging,
        didReceiveRegistrationToken fcmToken: String?
    ) {
        print("🔄 FCM 토큰 갱신: \(fcmToken ?? "nil")")
        
        guard let fcmToken = fcmToken else { return }
        
        // 🎯 Main Actor로 안전하게 전환해서 저장
//        Task { @MainActor in
//            await UserDefaultsManager.setFCMTokne(fcmToken)
//        }
    }
}

// MARK: - Error Types
public enum FirebaseError: Error, LocalizedError {
    case tokenNotAvailable
    case configurationFailed
    
    public var errorDescription: String? {
        switch self {
        case .tokenNotAvailable:
            return "FCM 토큰을 가져올 수 없습니다"
        case .configurationFailed:
            return "Firebase 설정에 실패했습니다"
        }
    }
}
