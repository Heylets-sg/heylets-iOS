import SwiftUI
import DSKit

struct SettingTimeTableView: View {
    @Binding var isShowingThemeView: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 25) {
            if !isShowingThemeView {
                Spacer()
                    .frame(height: 32)
                
                Button {
                    withAnimation {
                        isShowingThemeView.toggle()
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
        }
        .padding(.leading, 32)
        .padding(.trailing, 247)
        .cornerRadius(12, corners: [.topLeft, .topRight])
        .animation(.easeInOut, value: isShowingThemeView)   
    }
}
