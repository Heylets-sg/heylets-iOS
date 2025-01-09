//
//  BaseAPI.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public protocol BaseAPI: URLRequestTargetType { }

extension BaseAPI {
    public var url: String {
        return Config.baseURL
    }
    
    public var headers: [String: String]? {
        return APIHeaders.defaultHeader
    }
}
