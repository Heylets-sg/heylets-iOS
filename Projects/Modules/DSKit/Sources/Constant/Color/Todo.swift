//
//  Todo.swift
//  DSKit
//
//  Created by 류희재 on 4/7/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import Foundation
import SwiftUI

public extension Color {
    enum Todo {
        public static let addtodo = Color(DSKitAsset.addTodoDefault.color)
        public static let contents = Color(DSKitAsset.contentsDefault.color)
    }

    static var todo: Todo.Type {
        return Todo.self
    }
}
