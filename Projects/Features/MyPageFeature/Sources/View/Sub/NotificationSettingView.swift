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
            Color.common.Background.default.ignoresSafeArea()
            
            VStack(alignment: .leading) {
                Spacer()
                    .frame(height: 58)
                
                ZStack {
                    HStack {
                        Spacer()
                        
                        Text("Notification setting")
                            .font(.semibold_18)
                            .foregroundColor(.common.MainText.default)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Button {
                            viewModel.send(.backButtonDidTap)
                        } label: {
                            Image(uiImage: .icBack.withRenderingMode(.alwaysTemplate))
                                .resizable()
                                .frame(width: 24, height: 18)
                                .tint(.common.ButtonBack.default)
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

struct SelectTimePickerView: View {
    var timeArr: [String]
    var onSelect: (String) -> Void
    var onDismiss: () -> Void
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach(timeArr, id: \.self) { time in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                            
                            Text(time)
                                .font(.medium_14)
                                .foregroundColor(.common.SubText.default)
                            
                            Spacer()
                        }
                        .padding(.vertical, 20)
                        .onTapGesture {
                            onSelect(time)
                        }
                        
                        Divider()
                            .background(Color.common.Divider.default)
                    }
                }
            }
            .background(Color.common.Background.default)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            
            Spacer()
                .frame(height: 20)
            
            Button {
                onDismiss()
            } label: {
                Text("Back")
                    .font(.semibold_14)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.timeTableMain.bottomSheet)
                    .foregroundColor(.common.Placeholder.default)
                    .cornerRadius(8)
            }
        }
        .padding(.horizontal, 16)
        .background(Color.clear)
    }
}

// MARK: - Daily Briefing Section
struct DailyBriefingSection: View {
    @Binding var isToggleOn: Bool
    @Binding var briefingTime: String // Stored as "HH:mm" in ViewModel
    @State private var showTimePicker = false
    
    let briefingTimeArr = [
        "AM 06:00",
        "AM 07:00",
        "AM 08:00",
        "AM 09:00",
        "AM 10:00",
        "AM 11:00"
    ]
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Daily briefing")
                        .font(.semibold_16)
                        .foregroundColor(.common.MainText.default)
                        .lineSpacing(8)
                        .padding(.bottom, 4)
                    
                    Text("ex. There's two modules today")
                        .font(.regular_12)
                        .foregroundColor(.common.MainText.default)
                        .lineSpacing(12)
                        .padding(.bottom, 4)
                }
                
                Spacer()
                
                Toggle("", isOn: $isToggleOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color.toggle.default))
                    .labelsHidden()
                    .padding(.trailing, 15)
            }
            
            HStack {
                Text("Notification time")
                    .font(.regular_12)
                    .foregroundColor(.common.MainText.default)
                
                Spacer()
                
                Button(action: {
                    showTimePicker.toggle()
                }) {
                    Text(Date.fromTimeString(briefingTime)?.timeToString() ?? "AM 09:00")
                        .font(.regular_12)
                        .foregroundColor(.common.MainText.default)
                }
                .padding(.trailing, 15)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .background(Color.mypage.menubox)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showTimePicker) {
            SelectTimePickerView(
                timeArr: briefingTimeArr,
                onSelect: { selectedTime in
                    // Convert AM/PM format to 24-hour format for the viewModel
                    if let date = convertAMPMToDate(selectedTime) {
                        briefingTime = date.timeToString24()
                    }
                    showTimePicker = false
                },
                onDismiss: {
                    showTimePicker = false
                }
            )
            .presentationDetents([.height(CGFloat(60 * briefingTimeArr.count + 76))])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }
    
    // Helper function to convert AM/PM format string to Date
    private func convertAMPMToDate(_ timeString: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        return formatter.date(from: timeString)
    }
}

// MARK: - Class Notification Section
struct ClassNotificationSection: View {
    @Binding var isToggleOn: Bool
    @Binding var notificationMinute: Int
    @State private var showMinutePicker = false
    
    let minuteArr = [
        "5 min",
        "10 min",
        "15 min",
        "20 min",
        "25 min",
        "30 min",
        "1 hour"
    ]
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text("Class")
                        .font(.semibold_16)
                        .foregroundColor(.common.MainText.default)
                        .lineSpacing(8)
                        .padding(.bottom, 4)
                    
                    Text("ex. There's two modules today")
                        .font(.regular_12)
                        .foregroundColor(.common.MainText.default)
                        .lineSpacing(12)
                        .padding(.bottom, 4)
                }
                
                Spacer()
                
                Toggle("", isOn: $isToggleOn)
                    .toggleStyle(SwitchToggleStyle(tint: Color.toggle.default))
                    .labelsHidden()
                    .padding(.trailing, 15)
            }
            
            HStack {
                Text("Notification time")
                    .font(.regular_12)
                    .foregroundColor(.common.MainText.default)
                
                Spacer()
                
                Button(action: {
                    showMinutePicker.toggle()
                }) {
                    Text("\(notificationMinute) min before")
                        .font(.regular_12)
                        .foregroundColor(.common.MainText.default)
                }
                .padding(.trailing, 15)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 24)
        .background(Color.mypage.menubox)
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .sheet(isPresented: $showMinutePicker) {
            SelectTimePickerView(
                timeArr: minuteArr,
                onSelect: { selectedTime in
                    // Extract minutes from the selection
                    notificationMinute = parseMinutes(from: selectedTime)
                    showMinutePicker = false
                },
                onDismiss: {
                    showMinutePicker = false
                }
            )
            .presentationDetents([.height(CGFloat(60 * minuteArr.count + 76))])
            .presentationDragIndicator(.hidden)
            .presentationBackground(.clear)
        }
    }
    
    // Helper function to parse minutes from strings like "5 min", "10 min", etc.
    private func parseMinutes(from timeString: String) -> Int {
        if timeString == "1 hour" {
            return 60
        } else {
            // Extract the number from strings like "5 min", "10 min", etc.
            let components = timeString.components(separatedBy: " ")
            if let minuteStr = components.first, let minutes = Int(minuteStr) {
                return minutes
            }
            return 10 // Default value if parsing fails
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
