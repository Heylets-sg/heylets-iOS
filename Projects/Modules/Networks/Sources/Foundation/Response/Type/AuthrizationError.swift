//
//  AuthrizationError.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

extension HeyNetworkError {
    public enum AuthrizationError: Error, Equatable {
        case kakaoLoginError
        case appleLoginError
        
        var description: String {
            switch self {
            case .kakaoLoginError:
                return "카카오 로그인 시도 중 생긴 oauth 오류입니다"
            case .appleLoginError:
                return "애플 로그인 시도 중 생긴 oauth 오류입니다"
            }
        }
    }
}

extension HeyNetworkError.AuthrizationError {
    public func authrizationErrorMessage() -> String {
        return description
    }
}

