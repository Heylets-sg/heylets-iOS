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

public final class LectureCacheManager: @unchecked Sendable {
    public static let shared = LectureCacheManager()
    
    // MARK: - Cache Storage
    private var cachedLectureData: [String: CachedLectureData] = [:]
    private let cacheQueue = DispatchQueue(label: "lecture.cache.queue", attributes: .concurrent)
    
    // MARK: - Configuration
    private let cacheTimeout: TimeInterval = 1800 // 30분
    private let maxCacheSize = 20
    
    private init() {}
    
    // MARK: - Public Combine Methods
    
    /// 캐시된 강의 목록 조회 (특정 페이지)
    public func getCachedLectures(for cacheKey: String, page: Int) -> AnyPublisher<[SectionInfo]?, Never> {
        return Future { [weak self] promise in
            self?.cacheQueue.async {
                guard let self = self,
                      let cachedData = self.cachedLectureData[cacheKey],
                      !cachedData.isExpired(timeout: self.cacheTimeout),
                      cachedData.recentPageNum > page else {
                    print("❌ Lecture Cache MISS for key: \(cacheKey), page: \(page)")
                    promise(.success(nil))
                    return
                }
                
                let pageData = self.cachedLectureData[cacheKey]
                print("✅ Lecture Cache HIT for key: \(cacheKey), page: \(pageData?.recentPageNum), count: \(pageData?.lectures.count)")
                promise(.success(pageData?.lectures))
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// 강의 목록 캐시에 저장 (페이지 단위 추가)
    public func appendLectures(_ lectures: [SectionInfo], for cacheKey: String, page: Int) {
        cacheQueue.async(flags: .barrier) {
            self.performLecturesCacheOperation(lectures: lectures, cacheKey: cacheKey, page: page)
        }
    }
    
    /// 모든 캐시 무효화
    public func invalidateAllCache() {
        cacheQueue.async(flags: .barrier) {
            self.cachedLectureData.removeAll()
            print("🗑️ All lecture cache invalidated")
        }
    }
    
    // MARK: - Private Methods
    
    private func performLecturesCacheOperation(
        lectures: [SectionInfo],
        cacheKey: String,
        page: Int,
    ) {
        // 캐시 크기 관리
        if cachedLectureData.count >= maxCacheSize {
            removeOldestCache()
        }
        
        // 기존 캐시 데이터 가져오기 또는 새로 생성
        var cachedData = cachedLectureData[cacheKey] ?? CachedLectureData()
        
        // 메타데이터 업데이트
        cachedData.recentPageNum = page
        cachedData.timestamp = Date()
        cachedData.lectures += lectures
        
        // 캐시에 저장
        cachedLectureData[cacheKey] = cachedData
        
        print("✅ Lectures cached for key: \(cacheKey), page: \(page), total lectures: \(cachedData.lectures.count), loaded pages: \(cachedData.recentPageNum)")
    }
    
    private func removeOldestCache() {
        guard let oldestEntry = cachedLectureData.min(by: { $0.value.timestamp < $1.value.timestamp }) else {
            return
        }
        cachedLectureData.removeValue(forKey: oldestEntry.key)
        
        print("🗑️ Removed oldest lecture cache for key: \(oldestEntry.key)")
    }
    
    private func extractPageData(from cachedData: CachedLectureData, page: Int) -> [SectionInfo] {
        let pageSize = 50
        let startIndex = page * pageSize
        let endIndex = min(startIndex + pageSize, cachedData.lectures.count)
        
        guard startIndex < cachedData.lectures.count else {
            return []
        }
        
        return Array(cachedData.lectures[startIndex..<endIndex])
    }
}

// MARK: - Cache Key Generation
extension LectureCacheManager {
    /// 강의 목록 캐시 키 생성
    public func makeLecturesCacheKey(
        academicYear: String = "2024",
        semester: String = "TERM_2",
        department: String?
    ) -> String {
        let dept = department ?? "ALL"
        return "\(academicYear)_\(semester)_\(dept)"
    }
}


private struct CachedLectureData: Sendable {
    var lectures: [SectionInfo] = []     // 실제 강의 데이터 배열
    var recentPageNum: Int = 0        // 로딩된 페이지 번호들
    var timestamp: Date = Date()
    
    func isExpired(timeout: TimeInterval) -> Bool {
        isExpired(at: Date(), timeout: timeout)
    }
    
    func isExpired(at date: Date, timeout: TimeInterval) -> Bool {
        date.timeIntervalSince(timestamp) > timeout
    }
}
