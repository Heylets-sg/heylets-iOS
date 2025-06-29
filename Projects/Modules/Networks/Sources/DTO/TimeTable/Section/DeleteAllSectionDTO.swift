//
//  DeleteAllSectionDTO.swift
//  Networks
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct DeleteAllSectionResult: Decodable {
    let totalDeletedSchedules: Int
    let totalDeletedSections: Int
}
