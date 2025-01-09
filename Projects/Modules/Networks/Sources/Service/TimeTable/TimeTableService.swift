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
        _ academicYear: String,
        _ semester: String
    ) -> NetworkDecodableResponse<TimeTableListResult>
    
    func getTableDetailInfo(
        _ tableId: String
    ) -> NetworkDecodableResponse<TimeTableDetailInfoDTO>
    
    func patchTable(
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
        _ academicYear: String,
        _ semester: String
    ) -> NetworkDecodableResponse<TimeTableListResult> {
        requestWithResult(.getTableList(academicYear, semester))
    }
    
    public func getTableDetailInfo(
        _ tableId: String
    ) -> NetworkDecodableResponse<TimeTableDetailInfoDTO> {
        requestWithResult(.getTableDetailInfo(tableId))
    }
    
    public func patchTable(
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
