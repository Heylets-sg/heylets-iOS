//
//  CacheManagerType.swift
//  Data
//
//  Created by 류희재 on 8/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation

public protocol CacheManagerType: AnyObject {
    associatedtype CacheKey: Hashable, Sendable
    associatedtype CacheValue: Sendable
    associatedtype CachedData: CacheEntry where CachedData.Value == CacheValue
    
    var cacheStorage: [CacheKey: CachedData] { get set }
    var cacheQueue: DispatchQueue { get }
    var cacheTimeout: TimeInterval { get }
    var maxCachedSize: Int { get }
    
    func performCacheOperation(value: CacheValue, for key: CacheKey)
    func removeOldestCache()
}


public protocol CacheEntry {
    associatedtype Value
    var timestamp: Date { get }
    var data: Value { get }
    func isExpired(timeout: TimeInterval) -> Bool
}
