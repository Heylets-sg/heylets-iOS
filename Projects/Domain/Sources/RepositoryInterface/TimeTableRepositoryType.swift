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
        _ tableId: Int
    ) -> AnyPublisher<Void, Error>
    
    // 현재는 테이블 아이디를 가져오는 용도로만 사용됨
    func getTableList() -> AnyPublisher<Int?, Error>
    
    func getTableDetailInfo(
        _ tableId: Int
    ) -> AnyPublisher<TimeTableDetailInfo, Error>
    
    //추가하자마자 전체 API 불러올 생각이어서 일단 Void
    func patchTableName(
        _ tableId: Int,
        _ tableName: String
    ) -> AnyPublisher<Void, Error>
    
    // 현재는 테이블 아이디를 가져오는 용도로만 사용됨
    func postTable() -> AnyPublisher<Int, Error>
}
