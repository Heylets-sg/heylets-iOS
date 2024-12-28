import SwiftUI
import DSKit

struct SettingTimeTableView: View {
    @Binding var viewType: TimeTableViewType
    
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
                // Timetable name action
            } label: {
                Text("Timetable name")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
            }
            
            Button {
                // Share URL action
            } label: {
                Text("Share URL")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
            }
            
            Button {
                // Save image action
            } label: {
                Text("Save image")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
            }
            
            Button {
                // Remove all action
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
