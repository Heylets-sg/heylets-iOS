//
//  OnboardingView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import BaseFeatureDependency
import Core

public struct OnboardingView: View {
    @EnvironmentObject var router: Router
    var viewModel: OnboardingViewModel
    
    public init(viewModel: OnboardingViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        VStack {
            Button {
                viewModel.send(.buttonDidTap)
            } label: {
                Text("OnboardingView")
            }
        }
    }
}



//#Preview {
//    OnboardingView()
//}


public class OnboardingViewModel: ObservableObject {
    
    enum Action {
        case buttonDidTap
    }
    
    public var windowRouter: WindowRoutableType
    
    public init(windowRouter: WindowRoutableType) {
        self.windowRouter = windowRouter
        print(windowRouter.destination)
    }
    
    func send(_ action: Action) {
        switch action {
        case .buttonDidTap:
            print("버튼 클릭")
            windowRouter.switch(to: .splash)
        }
    }
}
