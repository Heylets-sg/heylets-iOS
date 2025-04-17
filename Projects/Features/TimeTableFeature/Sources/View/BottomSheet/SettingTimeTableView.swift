import SwiftUI

import BaseFeatureDependency
import Domain
import DSKit
import Core

struct SettingTimeTableView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var settingAlertType: TimeTableSettingAlertType?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Timetable setup")
                .foregroundColor(.common.MainText.default)
                .font(.semibold_16)
                .padding(.vertical, 20)
                .padding(.leading, 32)
            
            Divider()
                .frame(height: 0.8)
                .background(Color.common.Divider.default)
                .padding(.bottom, 12)
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    withAnimation {
                        viewType = .theme(false)
                    }
                } label: {
                    Text("Theme")
                        .font(.medium_14)
                        .foregroundColor(.common.MainText.default)
                }
                .padding(.bottom, 25)
                
                Button {
                    settingAlertType = .editTimeTableName
                    viewType = .main
                } label: {
                    Text("Timetable name")
                        .font(.medium_14)
                        .foregroundColor(.common.MainText.default)
                }
                .padding(.bottom, 25)
                
                Button {
                    settingAlertType = .saveImage
                    viewType = .main
                } label: {
                    Text("Save image")
                        .font(.medium_14)
                        .foregroundColor(.common.MainText.default)
                }
                .padding(.bottom, 25)
                
                Button {
                    settingAlertType = .removeTimeTable
                    viewType = .main
                } label: {
                    Text("Remove all")
                        .font(.medium_14)
                        .foregroundColor(.common.MainText.default)
                }
            }
            .padding(.leading, 32)
            .padding(.trailing, 220)
        }
        .animation(.easeInOut, value: viewType)
        .onDisappear {
            if viewType == .setting {
                viewType = .main
            }
        }
    }
}
