//
//  DecodeError.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

extension HMHNetworkError {
    public enum DecodeError: Error, Equatable {
        case decodingFailed
        case dataIsNil
        
        var description: String {
            switch self {
            case .decodingFailed:
                return "디코딩에 실패했습니다"
            case .dataIsNil:
                return "데이터가 존재하지 않습니다."
            }
        }
    }
}

