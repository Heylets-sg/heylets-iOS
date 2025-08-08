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

public protocol TimeTableCacheManagerType {
    func getCachedTableDetailInfo(for tableId: Int) -> AnyPublisher<TimeTableDetailInfo?, Never>
    func cache(tableDetailInfo: TimeTableDetailInfo, for tableId: Int)
    func deleteSection(for tableId: Int, _ sectionId: Int)
    func deleteAllSection(for tableId: Int)
    func addSection(for tableId: Int, _ section: SectionInfo)
}

final public class TimeTableCacheManager: BaseCacheManager<Int, TimeTableDetailInfo, CachedTimeTableDetailInfo>, TimeTableCacheManagerType, @unchecked Sendable {
    public static let shared = TimeTableCacheManager(.timeTable)
    
    public func getCachedTableDetailInfo(for tableId: Int) -> AnyPublisher<TimeTableDetailInfo?, Never> {
        return getCachedValue(for: tableId)
    }
    
    public func cache(tableDetailInfo: TimeTableDetailInfo, for tableId: Int) {
        cache(value: tableDetailInfo, for: tableId) { data in
            CachedTimeTableDetailInfo(data: data, timestamp: Date())
        }
        print("✅ TimeTable cached for ID: \(tableId), SectionList count: \(tableDetailInfo.sectionList.count)")
    }
}

extension TimeTableCacheManager {
    public func addSection(for tableId: Int, _ section: SectionInfo) {
            cacheQueue.async(flags: .barrier) {
                self.cacheStorage[tableId]?.data.sectionList.append(section)
            }
        }
        
        public func deleteSection(for tableId: Int, _ sectionId: Int) {
            cacheQueue.async(flags: .barrier) {
                guard var cached = self.cacheStorage[tableId] else { return }
                cached.data.sectionList.removeAll { $0.id == sectionId }
                self.cacheStorage[tableId] = cached
            }
        }
        
        public func deleteAllSection(for tableId: Int) {
            cacheQueue.async(flags: .barrier) {
                guard var cached = self.cacheStorage[tableId] else { return }
                cached.data.sectionList.removeAll()
                self.cacheStorage[tableId] = cached
            }
        }
}

public struct CachedTimeTableDetailInfo: Sendable, CacheEntry {
    public func isExpired(timeout: TimeInterval) -> Bool {
        isExpired(at: Date())
    }
    
    public var data: TimeTableDetailInfo
    public let timestamp: Date
     
    func isExpired(at date: Date) -> Bool {
        date.timeIntervalSince(timestamp) > 300 // 5분
    }
}
