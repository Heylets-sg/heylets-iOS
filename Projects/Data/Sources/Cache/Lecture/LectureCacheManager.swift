//
//  LectureCacheManager.swift
//  Data
//
//  Created by 류희재 on 8/5/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain

public typealias LectureBaseCacheManager = BaseCacheManager<String, LectureCacheValue, CachedLectureData>

public protocol LectureCacheManagerType {
    func getCachedLectures(
        for department: String?,
        page: Int
    ) -> AnyPublisher<LectureListInfo?, Never>
    
    func appendLectures(
        _ data: LectureListInfo,
        for department: String?,
        page: Int
    )
}

public final class LectureCacheManager: LectureBaseCacheManager, LectureCacheManagerType,  @unchecked Sendable {
    public static let shared = LectureCacheManager(.lecture)
    
    public func getCachedLectures(
        for department: String? = nil,
        page: Int
    ) -> AnyPublisher<LectureListInfo?, Never> {
        let cacheKey = makeLecturesCacheKey(department: department)
        return getCachedValue(for: cacheKey)
            .map { cacheValue in
                guard let cacheValue = cacheValue,
                      cacheValue.recentPageNum > page else {
                    return nil
                }
                
                return LectureListInfo(
                    lectureList: cacheValue.lectures,
                    pageNum: cacheValue.recentPageNum
                )
            }
            .eraseToAnyPublisher()
    }
    
    public func appendLectures(
        _ data: LectureListInfo,
        for department: String?,
        page: Int
    ) {
        let cacheKey = makeLecturesCacheKey(department: department)
        
        // 기존 캐시 데이터 가져오기
        let existingValue = cacheStorage[cacheKey]?.data ?? LectureCacheValue()
        
        // 새로운 값 생성
        let newValue = LectureCacheValue(
            lectures: existingValue.lectures + data.lectureList,
            recentPageNum: page
        )
        
        cache(value: newValue, for: cacheKey) { value in
            CachedLectureData(data: value, timestamp: Date())
        }
    }
}

extension LectureCacheManager {
    // 캐시 키 생성 메서드
    private func makeLecturesCacheKey(
        academicYear: String = "2024",
        semester: String = "TERM_2",
        department: String?
    ) -> String {
        let dept = department ?? "ALL"
        return "\(academicYear)_\(semester)_\(dept)"
    }
}


public struct LectureCacheValue: Sendable {
    var lectures: [SectionInfo]
    var recentPageNum: Int
    
    init(lectures: [SectionInfo] = [], recentPageNum: Int = 0) {
        self.lectures = lectures
        self.recentPageNum = recentPageNum
    }
}

public struct CachedLectureData: CacheEntry {
    public typealias Value = LectureCacheValue
    
    public var data: LectureCacheValue
    public let timestamp: Date
    
    init(data: LectureCacheValue = LectureCacheValue(), timestamp: Date = Date()) {
        self.data = data
        self.timestamp = timestamp
    }
    
    public func isExpired(timeout: TimeInterval) -> Bool {
        isExpired(at: Date(), timeout: timeout)
    }
    
    func isExpired(at date: Date, timeout: TimeInterval) -> Bool {
        date.timeIntervalSince(timestamp) > timeout
    }
}
