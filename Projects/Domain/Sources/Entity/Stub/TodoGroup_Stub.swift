//
//  TodoGroup_Stub.swift
//  Domain
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

extension TodoGroup {
    static nonisolated(unsafe) public var list: [TodoGroup] =  [
        .group_stub1,
        .group_stub2,
        .group_stub3,
        .group_stub4
    ]
    
    static public var group_stub1: Self {
        .init(
            id: 1,
            type: .default,
            name: "1번 그룹",
            items: [
                .init(
                    id: 1,
                    content: "watching new video watching new video watching new video ",
                    completed: true
                ),
                .init(
                    id: 2,
                    content: "1-2번 아이템",
                    completed: true
                )
            ]
        )
    }
    
    static public var group_stub2: Self {
        .init(
            id: 2,
            type: .default,
            name: "2번 그룹",
            items: [
                .init(
                    id: 3,
                    content: "2-1번 아이템",
                    completed: true
                ),
                .init(
                    id: 4,
                    content: "2-2번 아이템",
                    completed: false
                )
            ]
        )
    }
    
    static public var group_stub3: Self {
        .init(
            id: 3,
            type: .custom,
            name: "3번 그룹",
            items: [
                .init(
                    id: 5,
                    content: "3-1번 아이템",
                    completed: false
                ),
                .init(
                    id: 6,
                    content: "3-2번 아이템",
                    completed: true
                )
            ]
        )
    }
    
    static public var group_stub4: Self {
        .init(
            id: 4,
            type: .custom,
            name: "1번 그룹",
            items: [
                .init(
                    id: 7,
                    content: "4-1번 아이템",
                    completed: false
                ),
                .init(
                    id: 8,
                    content: "4-2번 아이템",
                    completed: false
                )
            ]
        )
    }
}
