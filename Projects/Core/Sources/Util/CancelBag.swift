//
//  CancelBag.swift
//  Core
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Combine
import Foundation

public final class CancelBag: @unchecked Sendable {
    private let lock = NSLock()
    public private(set) var subscriptions = Set<AnyCancellable>()
    
    public func cancel() {
        lock.lock()
        defer { lock.unlock() }
        subscriptions.forEach { $0.cancel() }
        subscriptions.removeAll()
    }
    
    public func store(_ cancellable: AnyCancellable) {
        lock.lock()
        defer { lock.unlock() }
        subscriptions.insert(cancellable)
    }
    
    public init() { }
}

extension AnyCancellable {
    public func store(in cancelBag: CancelBag) {
        cancelBag.store(self)
    }
}
