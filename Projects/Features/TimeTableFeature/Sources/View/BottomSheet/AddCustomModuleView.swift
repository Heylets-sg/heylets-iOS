//
//  ClassAddView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
import Domain

public struct AddCustomModuleView: View {
    @ObservedObject var viewModel: AddCustomModuleViewModel
    
    public var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 48)
            
            HStack(spacing: 6) {
                HStack {
                    Menu(viewModel.day.rawValue) {
                        ForEach(Week.allCases.sorted(by: { $0.index > $1.index}), id: \.self) { day in
                            Button(day.rawValue, action: {
                                viewModel.send(.weekPickerButtonDidTap(day))
                            })
                        }
                    }
                    .font(.regular_14)
                    .foregroundColor(.heyGray1)
                    .padding(.trailing, 6)
                    
                    Image(uiImage: .icDown)
                        .resizable()
                        .frame(width: 9, height: 4)
                }
                
                Menu(viewModel.time) {
                    ForEach(viewModel.timeList.sorted(by: >), id: \.self) { time in
                        Button(time, action: {
                            viewModel.send(.timePickerButtonDidTap(time))
                        })
                    }
                }
                .font(.regular_14)
                .foregroundColor(.heyGray1)
                .padding(.trailing, 6)
                
                Image(uiImage: .icDown)
                    .resizable()
                    .frame(width: 9, height: 4)
            }
            .padding(.bottom, 24)
            
            VStack(spacing: 20) {
                VStack {
                    TextField(
                        "",
                        text: $viewModel.schedule,
                        prompt: Text("Schedule")
                            .font(.regular_14)
                            .foregroundColor(.heyGray2)
                    )
                    
                    Divider()
                        .foregroundColor(.heyGray2)
                }
                
                VStack {
                    TextField(
                        "",
                        text: $viewModel.location,
                        prompt: Text("Location(option)")
                            .font(.regular_14)
                            .foregroundColor(.heyGray2)
                    )
                    
                    Divider()
                        .foregroundColor(.heyGray2)
                }
                
                VStack {
                    TextField(
                        "",
                        text: $viewModel.professor,
                        prompt: Text("Professor(option)")
                            .font(.regular_14)
                            .foregroundColor(.heyGray2)
                    )
                    
                    Divider()
                        .foregroundColor(.heyGray2)
                }
            }
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}


#Preview {
    @State var stub: TimeTableViewType = .main
    return AddCustomModuleView(
        viewModel: .init(StubHeyUseCase.stub.timeTableUseCase)
    )
}
