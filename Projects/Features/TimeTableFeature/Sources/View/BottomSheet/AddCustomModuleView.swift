//
//  ClassAddView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct AddCustomModuleView: View {
    @ObservedObject var viewModel: AddCustomModuleViewModel
    
    public var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 48)
            
            HStack(spacing: 6) {
                Button {
                    viewModel.send(.weekPickerButtonDidTap)
                } label: {
                    HStack {
                        Text(viewModel.day.rawValue)
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                            .padding(.trailing, 6)
                        
                        Image(uiImage: .icDown)
                            .resizable()
                            .frame(width: 9, height: 4)
                    }
                }
                
                Button {
                    viewModel.send(.timePickerButtonDidTap)
                } label: {
                    HStack {
                        Text(viewModel.time)
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                            .padding(.trailing, 6)
                        Image(uiImage: .icDown)
                            .resizable()
                            .frame(width: 9, height: 4)
                    }
                }
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
            
            if !viewModel.state.weekPickerIsHidden {
                Picker("", selection: $viewModel.day) {
                    ForEach(viewModel.dayofWeeks, id: \.self) { day in
                        Text(day.rawValue).tag(day.rawValue)
                    }
                }
                .pickerStyle(.wheel)
                .background(.white)
                .cornerRadius(16)
                .padding()
            }
            
            if !viewModel.state.timePickerIsHidden {
                Picker("", selection: $viewModel.time) {
                    ForEach(viewModel.timeList, id: \.self) { time in
                        Text(time).tag(time)
                    }
                }
                .pickerStyle(.wheel)
                .background(.white)
                .cornerRadius(16)
                .padding()
            }
        }
        .padding(.horizontal, 16)
    }
}
