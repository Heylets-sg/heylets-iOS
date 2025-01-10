//
//  AddSectionDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct AddSectionRequest: Encodable {
    let sectionId: Int
    let memo: String
    
    public init(
        _ sectionId: Int,
        _ memo: String
    ) {
        self.sectionId = sectionId
        self.memo = memo
    }
}
