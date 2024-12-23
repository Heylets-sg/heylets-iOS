//
//  SelectUniversityView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import DSKit

public struct SelectUniversityView: View {
    @EnvironmentObject var router: Router
    var viewModel: SelectUniversityViewModel
    @State var text = ""
    
    public init(viewModel: SelectUniversityViewModel) {
        self.viewModel = viewModel
    }
    public var body: some View {
        OnboardingBaseView(content: {
            HeyTextField(text: $text, placeHolder: "Select your university", leftImage: .icSchool, textFieldState: .idle)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.heyMain, lineWidth: 2)
                )            
        }, titleText: "What school are you attending?")
    }
}

//#Preview {
//    SelectUniversityView()
//}
