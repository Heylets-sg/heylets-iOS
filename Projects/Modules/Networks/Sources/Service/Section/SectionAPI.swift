//
//  SectionAPI.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

import Domain

public enum SectionAPI {
}

extension SectionAPI: BaseAPI {
    public var isWithInterceptor: Bool {
        return false
    }
    
    public var path: String? {
        switch self {
        }
    }
    
    public var method: HTTPMethod {
        return .get
    }
    
    public var task: Task {
        switch self {
        }
    }
    
    public var headers: [String : String]? {
        return APIHeaders.defaultHeader
    }
}





