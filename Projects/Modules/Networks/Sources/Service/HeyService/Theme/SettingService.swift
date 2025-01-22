//
//  ThemeService.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias SettingService = BaseService<SettingAPI>

public protocol SettingServiceType {
    func getThemeDetailInfo(
        _ themeName: String
    ) -> NetworkDecodableResponse<ThemeDetailInfoResult>
    
    func getThemeList() -> NetworkDecodableResponse<ThemePreviewResult>
    
    func getTimeTableSettingInfo() -> NetworkDecodableResponse<TimeTableSettingResult>
    
    func patchTimeTableSettingInfo(
        _ request: TimeTableSettingRequest
    ) -> NetworkDecodableResponse<TimeTableSettingResult>
}

extension SettingService: SettingServiceType {
    public func getThemeDetailInfo(
        _ themeName: String
    ) -> NetworkDecodableResponse<ThemeDetailInfoResult> {
        requestWithResult(.getThemeDetailInfo(themeName))
    }
    
    public func getThemeList() -> NetworkDecodableResponse<ThemePreviewResult> {
        requestWithResult(.getPreviewTheme)
    }
    
    public func getTimeTableSettingInfo() -> NetworkDecodableResponse<TimeTableSettingResult> {
        requestWithResult(.getTimeTableSetting)
    }
    
    public func patchTimeTableSettingInfo(
        _ request: TimeTableSettingRequest
    ) -> NetworkDecodableResponse<TimeTableSettingResult> {
        requestWithResult(.patchTimeTableSetting(request))
    }
}
