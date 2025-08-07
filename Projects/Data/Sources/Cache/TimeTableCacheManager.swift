//
//  TimeTableCacheManager.swift
//  Data
//
//  Created by 류희재 on 8/1/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

import Domain

public final class TimeTableCacheManager: @unchecked Sendable {
    public static let shared = TimeTableCacheManager()
    
    // MARK: - Cache Storage
    private var cachedTableDetailInfo: [Int: CachedTimeTableDetailInfo] = [:]
    private let cacheQueue = DispatchQueue(label: "timeTable.cache.queue", attributes: .concurrent)
    
    // MARK: - Configuration
    private let cacheTimeout: TimeInterval = 300 // 5분
    private let maxCacheSize = 10
    
    // MARK: - Public Combine Methods
    
    /// 캐시된 시간표 상세 정보 조회
    public func getCachedTableDetailInfo(for tableId: Int) -> AnyPublisher<TimeTableDetailInfo?, Never> {
        return Future { [weak self] promise in
            self?.cacheQueue.async {
                guard let self = self,
                      let cachedInfo = self.cachedTableDetailInfo[tableId],
                      !cachedInfo.isExpired else {
                    promise(.success(nil))
                    return
                }
                print("✅ Cache HIT for tableId: \(tableId)")
                
                promise(.success(cachedInfo.data))
            }
        }
        .eraseToAnyPublisher()
    }
    
    /// 시간표 상세 정보 캐시에 저장
    public func cache(tableDetailInfo: TimeTableDetailInfo, for tableId: Int){
        cacheQueue.async(flags: .barrier) {
            self.performCacheOperation(tableDetailInfo: tableDetailInfo, for: tableId)
        }
    }
    
    /// 특정 시간표 캐시 무효화
    public func invalidateCache(for tableId: Int) {
        cacheQueue.async(flags: .barrier) {
            self.cachedTableDetailInfo.removeValue(forKey: tableId)
            print("🗑️ Cache invalidated for tableId: \(tableId)")
        }
    }
    
    /// 모든 캐시 무효화
    public func invalidateAllCache(){
        cacheQueue.async(flags: .barrier) {
            self.cachedTableDetailInfo.removeAll()
            print("🗑️ All cache invalidated")
        }
    }
    
    // MARK: - Private Methods
    
    private func performCacheOperation(tableDetailInfo: TimeTableDetailInfo, for tableId: Int) {
        // 캐시 크기 관리
        if cachedTableDetailInfo.count >= maxCacheSize {
            removeOldestCache()
        }
        
        // 새로운 데이터 캐시
        let cachedInfo = CachedTimeTableDetailInfo(
            data: tableDetailInfo,
            timestamp: Date()
        )
        cachedTableDetailInfo[tableId] = cachedInfo
        
        print("✅ TimeTable cached for ID: \(tableId), SectionList count: \(tableDetailInfo.sectionList.count)")
    }
    
    private func removeOldestCache() {
        guard let oldestEntry = cachedTableDetailInfo.min(by: { $0.value.timestamp < $1.value.timestamp }) else {
            return
        }
        cachedTableDetailInfo.removeValue(forKey: oldestEntry.key)
        
        print("🗑️ Removed oldest cache for tableId: \(oldestEntry.key)")
    }
}

extension TimeTableCacheManager {
    /// 특정 시간표 - 섹션 추가
    public func addSection(for tableId: Int, _ section: SectionInfo) {
        cacheQueue.async(flags: .barrier) {
            self.cachedTableDetailInfo[tableId]?.data.sectionList.append(section)
        }
    }
    
    /// 특정 시간표 - 섹션 제거
    public func deleteSection(for tableId: Int, _ sectionId: Int) {
        cacheQueue.async(flags: .barrier) {
            guard var cached = self.cachedTableDetailInfo[tableId] else { return }
            
            cached.data.sectionList.removeAll { $0.id == sectionId }
            self.cachedTableDetailInfo[tableId] = cached
        }
    }
    
    /// 특정 시간표 - 모든 섹션  제거
    public func deleteAllSection(for tableId: Int) {
        cacheQueue.async(flags: .barrier) {
            guard var cached = self.cachedTableDetailInfo[tableId] else { return }
            
            cached.data.sectionList.removeAll()
            self.cachedTableDetailInfo[tableId] = cached
        }
    }
}

private struct CachedTimeTableDetailInfo: Sendable {
    var data: TimeTableDetailInfo
    let timestamp: Date
    
    var isExpired: Bool {
        isExpired(at: Date())
    }
    
    func isExpired(at date: Date) -> Bool {
        date.timeIntervalSince(timestamp) > 300 // 5분
    }
}
