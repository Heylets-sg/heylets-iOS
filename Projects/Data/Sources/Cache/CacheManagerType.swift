//
//  CacheManagerType.swift
//  Data
//
//  Created by 류희재 on 8/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

protocol CacheManagerType {
    associatedtype CacheKey: Hashable
    associatedtype CacheValue
    associatedtype CachedData: TimestampedCachedData where CachedData.Value == CacheValue
    
    var cacheStorage: [CacheKey: CachedData] { get set }
    var cacheQueue: DispatchQueue { get }
    var cacheTimeout: TimeInterval { get }
    var maxCachedSize: Int { get }
    
    func performCacheOperation(value: CacheValue, for key: CacheKey)
    func removeOldestCache()
}


protocol TimestampedCachedData {
    associatedtype Value
    var timestamp: Data { get }
    var data: Value { get }
    func isExpired(timeout: TimeInterval) -> Bool
}
