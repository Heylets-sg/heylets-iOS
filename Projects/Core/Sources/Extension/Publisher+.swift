//
//  Publisher+.swift
//  Core
//
//  Created by 류희재 on 1/2/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine
import SwiftUI

extension Publisher {

    func assignLoading<Root>(to keyPath: ReferenceWritableKeyPath<Root, Bool>, on object: Root) -> Publishers.HandleEvents<Self> {
        handleEvents(
            receiveCompletion: { _ in object[keyPath: keyPath] = false },
            receiveRequest: { _ in object[keyPath: keyPath] = true }
        )
    }
}

