//
//  ReportMissingModuleView.swift
//  DSKit
//
//  Created by 류희재 on 12/26/24.
//  Copyright © 2024 Heylets-iOS. All rights reserved.
//

import SwiftUI

import DSKit

struct ReportMissingModuleView: View {
    @Binding var reportMissingModuleAlertIsPresented: Bool
    @State var text = ""
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
                .frame(height: 104)
            
            Text("Report Missing Modules")
                .font(.semibold_18)
                .foregroundColor(.common.MainText.default)
                .padding(.bottom, 8)
            
            Text("It will be reviewed and registered\nwithin 3 days.")
                .font(.regular_16)
                .foregroundColor(.common.SubText.default)
                .padding(.bottom, 32)
            
            HeyTextField(text: $text, placeHolder: "ex) Carrer and Enterpreurial")
            
            Spacer()
            
            Button("Back") {
                reportMissingModuleAlertIsPresented = false
            }.heyCTAButtonStyle()
            
            Spacer()
                .frame(height: 65)
            
        }
        .padding(.horizontal, 16)
    }
}

//#Preview {
//    ReportMissingModuleView()
//}
