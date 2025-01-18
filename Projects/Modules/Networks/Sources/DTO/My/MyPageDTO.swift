//
//  MyPageDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct MyProfileResult: Decodable {
    public let nickname: String
    public let university: String
    public let profileImageUrl: String?
}

public struct EditNameRequest: Encodable {
    let nickName: String
    
    public init(_ nickName: String) {
        self.nickName = nickName
    }
}
