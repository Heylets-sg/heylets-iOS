import SwiftUI
import BaseFeatureDependency
import Domain
import DSKit

struct SettingTimeTableView: View {
    @Binding var viewType: TimeTableViewType
    @Binding var settingAlertType: TimeTableSettingAlertType?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Timetable setup")
                .foregroundColor(.heyBlack)
                .font(.semibold_16)
                .padding(.vertical, 20)
                .padding(.leading, 32)
            
            Divider()
                .frame(height: 0.8)
                .background(Color.heyGray5)
                .padding(.bottom, 12)
            
            VStack(alignment: .leading, spacing: 0) {
                Button {
                    withAnimation {
                        viewType = .theme
                    }
                } label: {
                    Text("Theme")
                        .font(.medium_14)
                        .foregroundColor(.heyGray1)
                }
                .padding(.bottom, 25)
                
                Button {
                    settingAlertType = .editTimeTableName
                    viewType = .main
                } label: {
                    Text("Timetable name")
                        .font(.medium_14)
                        .foregroundColor(.heyGray1)
                }
                .padding(.bottom, 25)
                
                Button {
                    settingAlertType = .shareURL
                    viewType = .main
                } label: {
                    Text("Share URL")
                        .font(.medium_14)
                        .foregroundColor(.heyGray1)
                }
                .padding(.bottom, 25)
                
                Button {
                    settingAlertType = .saveImage
                    viewType = .main
                } label: {
                    Text("Save image")
                        .font(.medium_14)
                        .foregroundColor(.heyGray1)
                }
                .padding(.bottom, 25)
                
                Button {
                    settingAlertType = .removeTimeTable
                    viewType = .main
                } label: {
                    Text("Remove all")
                        .font(.medium_14)
                        .foregroundColor(.heyGray1)
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

#Preview {
    @State var stub: TimeTableViewType = .setting
    let useCase = StubHeyUseCase.stub.timeTableUseCase
    return TimeTableView(
        viewModel: .init(useCase),
        searchModuleViewModel: .init(useCase),
        addCustomModuleViewModel: .init(useCase),
        themeViewModel: .init(useCase)
    )
    .environmentObject(Router.default)
}
