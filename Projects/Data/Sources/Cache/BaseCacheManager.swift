//
//  BaseCacheManager.swift
//  Data
//
//  Created by 류희재 on 8/8/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

final class BaseCacheManager<Key: Hashable, Value, CachedType: TimestampedCacheData>: @unchecked Sendable
where CachedType.Value == Value {
}
