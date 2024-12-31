//
//  EnterPersonalInfoView.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
//import BaseFeatureDependency
//import DSKit

public struct EnterPersonalInfoView: View {
    //    @EnvironmentObject var router: Router
    @ObservedObject var viewModel: EnterPersonalInfoViewModel
    var genderList: [Gender] = [.men, .women, .others]
    
    @State var date = Date()
    
    public init(viewModel: EnterPersonalInfoViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        OnboardingBaseView(content: {
            Spacer()
                .frame(height: 8)
            
            HStack(spacing: 16) {
                ForEach(genderList, id: \.self) { gender in
                    GenderButton(
                        title: gender.title,
                        isSelected: gender == viewModel.gender,
                        action: { viewModel.send(.genderButtonDidTap(gender)) }
                    )
                }
            }
            .padding(.trailing, 62)
            .padding(.bottom, 20)
            
            VStack(alignment: .leading) {
                ZStack {
                    // 배경색을 원하는 색으로 설정
                    Color.blue.opacity(0.2)
                        .cornerRadius(10) // 배경을 둥글게 만들기

                    DatePicker(
                        "",
                        selection: $viewModel.birth,
                        displayedComponents: [.date]
                    )
                    .onChange(of: viewModel.birth) { date in
                        viewModel.send(.birthDayDidChange(date))
                    }
                    .labelsHidden()
                }
                .frame(height: 44) // 원하는 높이 설정
                .padding()
            }
            
            
        }, titleText: "Please check your gender/birth")
    }
}

fileprivate struct GenderButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(height: 56)
                .frame(maxWidth: .infinity)
                .font(.semibold_14)
                .background(isSelected ? Color.heyMain : Color.heyGray4)
                .foregroundStyle(Color.heyBlack)
                .clipShape(RoundedRectangle(cornerRadius: 8))
        }
    }
}
#Preview {
    EnterPersonalInfoView(viewModel: EnterPersonalInfoViewModel())
}


//
//  EnterPersonalInfoViewModel.swift
//  OnboardingFeature
//
//  Created by 류희재 on 12/19/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import Foundation
import Combine

//import BaseFeatureDependency

enum Gender {
    case men
    case women
    case others
    
    var title: String {
        switch self {
        case .men:
            return "Men"
        case .women:
            return "Women"
        case .others:
            return "Others"
        }
    }
}

public class EnterPersonalInfoViewModel: ObservableObject {
    struct State {
    }
    
    enum Action {
        case backButtonDidTap
        case nextButtonDidTap
        case genderButtonDidTap(Gender)
        case birthDayDidChange(Date)
    }
    
    //    public var navigationRouter: OnboardingNavigationRouter
    //    private var user: User
    
    @Published var state = State()
    @Published var gender: Gender = .men
    @Published var birth: Date = Date()
    
    //    public init(
    ////        navigationRouter: OnboardingNavigationRouter,
    ////        user: User
    //    ) {
    //        self.navigationRouter = navigationRouter
    //        self.user = user
    //    }
    
    func send(_ action: Action) {
        switch action {
        case .backButtonDidTap:
            break
            //navigationRouter.pop()
        case .nextButtonDidTap:
            break
            //            navigationRouter.push(to: .enterIdPassword)
        case .genderButtonDidTap(let gender):
            self.gender = gender
        case .birthDayDidChange(let date):
            self.birth = date
        }
    }
}

