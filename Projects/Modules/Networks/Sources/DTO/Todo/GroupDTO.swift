//
//  ItemDTO.swift
//  Networks
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct EditGroupNameRequest: Encodable {
    let groupName: String
    
    public init(_ groupName: String) {
        self.groupName = groupName
    }
}

public struct CreateGroupRequest: Encodable {
    let groupName: String
    let type: String //(DEFAULT/CUSTOM)
    let timeTableSectionId: Int //시간표 섹션 ID (DEFAULT 타입인 경우 필수)
    
    public init(
        _ groupName: String,
        _ type: String,
        _ timeTableSectionId: Int
    ) {
        self.groupName = groupName
        self.type = type
        self.timeTableSectionId = timeTableSectionId
    }
}


public struct GroupResult: Decodable {
    let groupId: Int
    let groupName: String
    let sectionOrder: Int
    let items: [ItemResult]
    let type: String?
}
