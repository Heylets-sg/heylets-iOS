//
//  UniversityDTO.swift
//  Networks
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public struct UniversityRequest: Encodable {
    let university: String
    
    init(_ university: String) {
        self.university = university
    }
}

