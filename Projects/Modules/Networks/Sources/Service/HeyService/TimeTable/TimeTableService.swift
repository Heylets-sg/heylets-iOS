//
//  TimeTableService.swift
//  Networks
//
//  Created by 류희재 on 1/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public typealias TimeTableService = BaseService<TimeTableAPI>

public protocol TimeTableServiceType {
    func deleteTable(
        _ tableId: String
    ) -> NetworkVoidResponse
    
    func getTableList(
    ) -> NetworkDecodableResponse<TimeTableListResult>
    
    func getTableDetailInfo(
        _ tableId: String
    ) -> NetworkDecodableResponse<TimeTableDetailInfoDTO>
    
    func patchTableName(
        _ tableId: String,
        _ request: TimeTableEditNameRequest
    ) -> NetworkDecodableResponse<TimeTableInfoResult>
    
    func postTable(
        _ request: AddTimeTableRequest
    ) -> NetworkDecodableResponse<TimeTableInfoResult>
}

extension TimeTableService: TimeTableServiceType {
    public func deleteTable(
        _ tableId: String
    ) -> NetworkVoidResponse {
        requestWithNoResult(.deleteTable(tableId))
    }
    
    public func getTableList(
    ) -> NetworkDecodableResponse<TimeTableListResult> {
        requestWithResult(.getTableList)
    }
    
    public func getTableDetailInfo(
        _ tableId: String
    ) -> NetworkDecodableResponse<TimeTableDetailInfoDTO> {
        requestWithResult(.getTableDetailInfo(tableId))
    }
    
    public func patchTableName(
        _ tableId: String,
        _ request: TimeTableEditNameRequest
    ) -> NetworkDecodableResponse<TimeTableInfoResult> {
        requestWithResult(.patchTable(tableId, request))
    }
    
    public func postTable(
        _ request: AddTimeTableRequest
    ) -> NetworkDecodableResponse<TimeTableInfoResult> {
        requestWithResult(.postTable(request))
    }
}
