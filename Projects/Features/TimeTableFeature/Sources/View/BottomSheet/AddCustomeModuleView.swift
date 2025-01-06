//
//  ClassAddView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

public struct AddCustomeModuleView: View {
    let dayofWeeks = Week.dayOfWeek
    let timeList = [
        "09:00 - 10:00",
        "10:00 - 11:00",
        "11:00 - 12:00",
        "12:00 - 13:00",
        "13:00 - 14:00",
        "14:00 - 15:00",
        "15:00 - 16:00",
        "16:00 - 17:00",
        "17:00 - 18:00",
        "18:00 - 19:00",
        "19:00 - 20:00",
        "20:00 - 21:00",
        "21:00 - 22:00",
        "22:00 - 23:00",
        "23:00 - 24:00"
    ]
    @State private var weekPickerIsHidden = true
    @State private var timePickerIsHidden = true
    @State private var text = ""
    @State private var day = "Mon"
    @State private var time = "09:00 - 10:00"
    
    public var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 48)
            
            HStack(spacing: 6) {
                Button {
                    self.weekPickerIsHidden.toggle()
                    self.timePickerIsHidden = true
                } label: {
                    HStack {
                        Text(day)
                            .font(.regular_14)
                            .foregroundColor(.heyGray1)
                            .padding(.trailing, 6)
                        
                        Image(uiImage: .icDown)
                            .resizable()
                            .frame(width: 9, height: 4)
                    }
                }
                
                Button {
                    self.weekPickerIsHidden = true
                    self.timePickerIsHidden.toggle()
                } label: {
                    HStack {
                        Text(time)
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
                        text: $text,
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
                        text: $text,
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
                        text: $text,
                        prompt: Text("Professor(option)")
                            .font(.regular_14)
                            .foregroundColor(.heyGray2)
                    )
                    
                    Divider()
                        .foregroundColor(.heyGray2)
                }
            }
            Spacer()
            
            if !weekPickerIsHidden {
                Picker("", selection: $day) {
                    ForEach(dayofWeeks, id: \.self) { day in
                        Text(day.rawValue).tag(day.rawValue)
                    }
                }
                .pickerStyle(.wheel)
                .background(.white)
                .cornerRadius(16)
                .padding()
            }
            
            if !timePickerIsHidden {
                Picker("", selection: $time) {
                    ForEach(timeList, id: \.self) { time in
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
