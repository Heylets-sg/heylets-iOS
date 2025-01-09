//
//  TimeTableRepositoryType.swift
//  Domain
//
//  Created by 류희재 on 1/9/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public protocol TimeTableRepositoryType {
    func deleteTable(
        _ tableId: String
    ) -> AnyPublisher<Void, Error>
    
    //MARK: 지금 MVP에서는 사용하지 않을거 같음 너묵 고민 ㄴㄴ
    func getTableList(
        _ academicYear: String,
        _ semester: String
    ) -> AnyPublisher<[TimeTableInfo], Error>
    
    func getTableDetailInfo(
        _ tableId: String
    ) -> AnyPublisher<TimeTableInfo, Error>
    
    //추가하자마자 전체 API 불러올 생각이어서 일단 Void
    func patchTableName(
        _ tableId: String,
        _ tableName: String
    ) -> AnyPublisher<Void, Error>
    
    func postTable(
        _ tableName: String,
        _ semester: String,
        _ academicYear: Int
    ) -> AnyPublisher<TimeTableInfo, Error>
}
