import SwiftUI
import DSKit

struct SettingTimeTableView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var settingAlertType: DemoTimeTableSettingAlertType?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            
            Spacer()
                .frame(height: 32)
            
            Button {
                withAnimation {
                    viewType = .theme
                }
            } label: {
                Text("Theme")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
            }
            
            Button {
                settingAlertType = .editTimeTableName
                viewType = .main
            } label: {
                Text("Timetable name")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
            }
            
            Button {
                settingAlertType = .shareURL
                viewType = .main
            } label: {
                Text("Share URL")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
            }
            
            Button {
                settingAlertType = .saveImage
                viewType = .main
            } label: {
                Text("Save image")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
            }
            
            Button {
                settingAlertType = .removeTimeTable
                viewType = .main
            } label: {
                Text("Remove all")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
            }
            
            Spacer()
        }
        .padding(.leading, 32)
        .padding(.trailing, 220)
        .cornerRadius(12, corners: [.topLeft, .topRight])
        .animation(.easeInOut, value: viewType)
        .onDisappear {
            if viewType == .setting {
                viewType = .main
            }
        }
    }
}
