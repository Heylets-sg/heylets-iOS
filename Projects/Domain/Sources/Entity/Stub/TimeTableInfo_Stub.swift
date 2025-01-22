//
//  TimeTableInfo_Stub.swift
//  Domain
//
//  Created by 류희재 on 1/15/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

extension TimeTableInfo {
    static public var empty: Self {
        .init(id: 0,
              name: "",
              semester: "",
              academicYear: 0,
              displayType: .MODULE_CODE
        )
    }
}
