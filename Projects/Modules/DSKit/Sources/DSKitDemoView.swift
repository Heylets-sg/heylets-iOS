//
//  DSKitDemoView.swift
//  DSKit
//
//  Created by 류희재 on 12/18/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI
struct DSKitDemoView: View {
    
    
    var body: some View {
        NavigationStack {
            List {
                NavigationLink("HeyBottomButton", destination: {heyBottomButton})
                NavigationLink("HeyTextField", destination: {heyTextField})
            }
        }
        
    }
    
    //MARK: - heyBottomButtonView
    
    @State var buttonDisabled = false
    var heyBottomButton: some View {
        VStack {
            //MARK: Case 1
            Button("기본 바텀 버튼") {
                // Action
            }
            .heyBottomButtonStyle()
            
            //MARK: Case 2
            Button("클릭시 비활성화 되는 버튼") {
                buttonDisabled = true
            }
            .disabled(buttonDisabled)
            .heyBottomButtonStyle()
        }
    }
    
    //MARK: - heyTextFieldView
    
    @State var text = ""
    var heyTextField: some View {
        TextField("", text: $text)
            .heyTextFieldStyle()
    }
}


#Preview {
    DSKitDemoView()
}

