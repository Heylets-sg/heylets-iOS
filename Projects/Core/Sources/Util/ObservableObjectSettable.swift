//
//  ObservableObjectSettable.swift
//  Core
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Combine

@MainActor
public protocol ObservableObjectSettable: AnyObject {
    var objectWillChange: ObservableObjectPublisher? { get set }
    func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher?)
}

@MainActor
public extension ObservableObjectSettable {
    func setObjectWillChange(_ objectWillChange: ObservableObjectPublisher?) {
        self.objectWillChange = objectWillChange
    }
    
    func notifyWillChange() {
        objectWillChange?.send()
    }
}

