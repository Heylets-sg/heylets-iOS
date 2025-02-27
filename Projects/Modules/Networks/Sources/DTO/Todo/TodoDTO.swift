//
//  GroupDTO.swift
//  Networks
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct TodoResult: Decodable {
    let sectionGroups: [GroupResult]
    let customGroups: [GroupResult]
}
