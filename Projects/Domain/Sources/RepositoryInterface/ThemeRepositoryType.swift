//
//  ThemeRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol ThemeRepositoryType {
    func getThemeDetailInfo(
        _ themeName: String
    ) -> AnyPublisher<ThemeColorInfo, Error>
    
    func getThemeList() -> AnyPublisher<[Theme], Error>
}
