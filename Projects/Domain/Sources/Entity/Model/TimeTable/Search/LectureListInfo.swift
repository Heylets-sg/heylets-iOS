//
//  LectureListInfo.swift
//  Domain
//
//  Created by 류희재 on 8/5/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

public struct LectureListInfo: Sendable {
    public let lectureList: [SectionInfo]
    public let pageNum: Int
    
    public init(
        lectureList: [SectionInfo] = [],
        pageNum: Int = 0
    ) {
        self.lectureList = lectureList
        self.pageNum = pageNum
    }
}
