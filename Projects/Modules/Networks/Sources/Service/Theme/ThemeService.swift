//
//  ThemeService.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias ThemeService = BaseService<ThemeAPI>

public protocol ThemeServiceType {
    func getThemeDetailInfo(
        _ themeName: String
    ) -> NetworkDecodableResponse<ThemeDetailInfoResult>
    
    func getThemeList() -> NetworkDecodableResponse<ThemePreviewResult>
}

extension ThemeService: ThemeServiceType {
    public func getThemeDetailInfo(
        _ themeName: String
    ) -> NetworkDecodableResponse<ThemeDetailInfoResult> {
        requestWithResult(.getThemeDetailInfo(themeName))
    }
    
    public func getThemeList() -> NetworkDecodableResponse<ThemePreviewResult> {
        requestWithResult(.getPreviewTheme)
    }
}
