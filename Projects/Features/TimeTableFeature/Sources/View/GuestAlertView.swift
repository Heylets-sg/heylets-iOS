//
//  GuestAlertView.swift
//  TimeTableFeature
//
//  Created by 류희재 on 2/18/25.
//  Copyright © 2025 Heylets-iOS. All rights reserved.
//

import SwiftUI




struct ContentView: View {
    @State private var showAlert = true
    
    var body: some View {
        VStack {
            Spacer()
            
            Button("Show Alert") {
                showAlert.toggle()
            }
        }
//        .heyAlert(isPresented: showAlert
    }
}

#Preview {
    ContentView()
}
