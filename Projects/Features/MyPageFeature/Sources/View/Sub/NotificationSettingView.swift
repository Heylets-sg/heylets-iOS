//
//  NotificationSettingView.swift
//  MyPageFeature
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import BaseFeatureDependency
import Domain

public struct NotificationSettingView: View {
    
    @ObservedObject var viewModel: NotificationSettingViewModel
    
    public init(viewModel: NotificationSettingViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        ZStack {
            Color.heyWhite.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 58)
                
                ZStack {
                    HStack {
                        Spacer()
                        
                        Text("Notification setting")
                            .font(.semibold_18)
                            .foregroundColor(.heyGray1)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            viewModel.send(.backButtonDidTap)
                        } label: {
                            Image(uiImage: .icBack.withRenderingMode(.alwaysTemplate))
                                .resizable()
                                .frame(width: 24, height: 18)
                                .tint(.heyGray1)
                        }
                        Spacer()
                    }
                    
                }
                
                Spacer()
                    .frame(height: 27)
                
                VStack(alignment: .leading, spacing: 20) {
                    DailyBriefingSection(
                        isToggleOn: $viewModel.state.dailyBriefingToggleOn,
                        briefingTime: $viewModel.briefingTime
                    )
                    
                    ClassNotificationSection(
                        isToggleOn: $viewModel.state.classToggleOn,
                        notificationMinute: $viewModel.classNotificationMinute
                    )
                }
                
                Spacer()
                
            }
            .padding(.horizontal, 16)
        }
        .ignoresSafeArea(edges: .vertical)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
        .onAppear {
            viewModel.send(.onAppear)
        }
    }
}

// MARK: - Daily Briefing Section
struct DailyBriefingSection: View {
    @Binding var isToggleOn: Bool
    @Binding var briefingTime: String // Now stored as "HH:mm" in ViewModel
    @State private var showTimePicker = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Daily briefing")
                        .font(.semibold_16)
                        .foregroundColor(.heyGray1)
                        .lineSpacing(8)
                        .padding(.bottom, 4)
                    
                    Text("ex. There's two modules today")
                        .font(.regular_12)
                        .foregroundColor(.heyGray1)
                        .lineSpacing(12)
                        .padding(.bottom, 4)
                }
                
                Spacer()
                
                Toggle("", isOn: $isToggleOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color.heyMain))
                    .labelsHidden()
                    .padding(.trailing, 15)
            }
            
            HStack {
                Text("Notification time")
                    .font(.regular_12)
                    .foregroundColor(.heyGray1)
                
                Spacer()
                
                Button(action: {
                    showTimePicker.toggle()
                }) {
                    // Convert 24-hour format to 12-hour format for display
                    Text(Date.fromTimeString(briefingTime)?.timeToString() ?? "AM 09:00")
                        .font(.regular_12)
                        .foregroundColor(.heyGray1)
                }
                .padding(.trailing, 15)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .background(Color.heyGray4)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showTimePicker) {
            TimePickerView(selectedTime: $briefingTime)
        }
    }
}

// MARK: - Class Notification Section
struct ClassNotificationSection: View {
    @Binding var isToggleOn: Bool
    @Binding var notificationMinute: Int
    @State private var showMinutePicker = false
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Class")
                        .font(.semibold_16)
                        .foregroundColor(.heyGray1)
                        .lineSpacing(8)
                        .padding(.bottom, 4)
                    
                    Text("ex. There's two modules today")
                        .font(.regular_12)
                        .foregroundColor(.heyGray1)
                        .lineSpacing(12)
                        .padding(.bottom, 4)
                }
                
                Spacer()
                
                Toggle("", isOn: $isToggleOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color.heyMain))
                    .labelsHidden()
                    .padding(.trailing, 15)
            }
            
            HStack {
                Text("Notification time")
                    .font(.regular_12)
                    .foregroundColor(.heyGray1)
                
                Spacer()
                
                Button(action: {
                    showMinutePicker.toggle()
                }) {
                    Text("\(notificationMinute) min before")
                        .font(.regular_12)
                        .foregroundColor(.heyGray1)
                }
                .padding(.trailing, 15)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .background(Color.heyGray4)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showMinutePicker) {
            MinutePickerView(selectedMinute: $notificationMinute)
        }
    }
}

// MARK: - Minute Picker View
struct MinutePickerView: View {
    @Binding var selectedMinute: Int
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            
            Picker("", selection: $selectedMinute) {
                ForEach(0..<60) { minute in
                    Text("\(minute) min")
                        .tag(minute)
                }
            }
            .pickerStyle(WheelPickerStyle())
            
            Spacer()
        }
        .background(Color.white)
        .interactiveDismissDisabled()
    }
}

// MARK: - Time Picker View
struct TimePickerView: View {
    @Binding var selectedTime: String
    @State private var date: Date
    @Environment(\.presentationMode) var presentationMode
    
    init(selectedTime: Binding<String>) {
        self._selectedTime = selectedTime
        let initialDate = Date.fromTimeString(selectedTime.wrappedValue) ?? Date()
        self._date = State(initialValue: initialDate)
    }
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Done") {
                    // Use 24-hour format for ViewModel storage
                    selectedTime = date.timeToString24()
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
            
            DatePicker(
                "",
                selection: $date,
                displayedComponents: [.hourAndMinute]
            )
            .datePickerStyle(WheelDatePickerStyle())
            .labelsHidden()
            
            Spacer()
        }
        .background(Color.white)
        .interactiveDismissDisabled()
    }
}

#Preview {
    NotificationSettingView(
        viewModel: .init(
            useCase: StubHeyUseCase.stub.myPageUseCase,
            navigationRouter: Router.default.navigationRouter
        )
    )
    .environmentObject(Router.default)
}
