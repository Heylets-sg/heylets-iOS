//
//  BaseCacheManager.swift
//  Data
//
//  Created by 류희재 on 8/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

public class BaseCacheManager<Key: Hashable & Sendable, Value: Sendable, CachedType: CacheEntry>: @unchecked Sendable
where CachedType.Value == Value {
    
    var cacheStorage: [Key: CachedType] = [:]
    let cacheQueue: DispatchQueue
    let cacheTimeout: TimeInterval
    let maxCacheSize: Int
    
    init(_ configuration: CacheConfiguration) {
        self.cacheQueue = DispatchQueue(label: configuration.queueLabel, attributes: .concurrent)
        self.cacheTimeout = configuration.timeout
        self.maxCacheSize = configuration.maxSize
    }
    
    func getCachedValue(for key: Key) -> AnyPublisher<Value?, Never> {
        return Future { [weak self] promise in
            self?.cacheQueue.async {
                guard let self = self,
                      let cachedData = self.cacheStorage[key],
                      !cachedData.isExpired(timeout: self.cacheTimeout) else {
                    promise(.success(nil))
                    return
                }
                promise(.success(cachedData.data))
            }
        }
        .eraseToAnyPublisher()
    }
    
    func cache(value: Value, for key: Key, createCachedData: @escaping (Value) -> CachedType) {
        cacheQueue.async(flags: .barrier) {
            self.performCacheOperation(value: value, for: key, createCachedData: createCachedData)
        }
    }

    private func performCacheOperation(
        value: Value,
        for key: Key,
        createCachedData: @escaping (Value) -> CachedType // 여기도 맞춰줌
    ) {
        if cacheStorage.count >= maxCacheSize {
            removeOldestCache()
        }
        cacheStorage[key] = createCachedData(value)
    }
    
    func invalidateCache(for key: Key) {
        cacheQueue.async(flags: .barrier) {
            self.cacheStorage.removeValue(forKey: key)
        }
    }
    
    func invalidateAllCache() {
        cacheQueue.async(flags: .barrier) {
            self.cacheStorage.removeAll()
        }
    }
    
    private func removeOldestCache() {
        guard let oldestEntry = cacheStorage.min(by: { $0.value.timestamp < $1.value.timestamp }) else {
            return
        }
        cacheStorage.removeValue(forKey: oldestEntry.key)
    }
}
