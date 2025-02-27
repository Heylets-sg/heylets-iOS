//
//  TodoView.swift
//  TodoFeature
//
//  Created by 류희재 on 2/27/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency

public struct TodoView: View {
    @EnvironmentObject var container: Router
    var viewModel: TodoViewModel
    
    public init(viewModel: TodoViewModel) {
        self.viewModel = viewModel
    }
    
    
    public var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}
