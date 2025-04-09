import SwiftUI
import Domain

import Core

struct SettingTimeTableInfoView: View {
    @ObservedObject var viewModel: ThemeViewModel
    
    var body: some View {
            VStack {
                if viewModel.state.isShowingSelectInfoView {
                    Color.timeTableMain.bottomSheet
                        .ignoresSafeArea()
                } else {
                    VStack {
                        Spacer()
                            .frame(height: 30.adjusted)
                        
                        HStack {
                            Text("Information")
                                .font(.medium_14)
                                .foregroundColor(.setting.title)
                            
                            Spacer()
                            
                            Button {
                                viewModel.send(.selectDisplayTypeButtonDidTap)
                            } label: {
                                Text(viewModel.displayType.text)
                                    .font(.regular_12)
                                    .foregroundColor(.setting.set)
                            }
                            
                            Spacer()
                        }
                        .padding(.leading, 24)
                        Spacer()
                    }
                    .background(Color.timeTableMain.bottomSheet)
                }
            }
            .sheet(isPresented: $viewModel.state.isShowingSelectInfoView) {
                SelectDisplayModuleView(viewModel: viewModel)
                    .presentationDetents([.height(350)])
                    .presentationDragIndicator(.hidden)
                    .presentationBackground(.clear)
            }
        }
    }



struct SelectDisplayModuleView: View {
    private var viewModel: ThemeViewModel
    
    init(viewModel: ThemeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                ForEach(DisplayTypeInfo.allCases, id: \.self) { option in
                    VStack(spacing: 0) {
                        HStack(spacing: 0) {
                            Spacer()
                            
                            Text(option.text)
                                .font(.medium_14)
                                .foregroundColor(.common.MainText.default)
                            
                            Spacer()
                        }
                        .padding(.vertical, 20.adjusted)
                        .onTapGesture {
                            withAnimation {
                                viewModel.send(.selectDisplayType(option))
                            }
                        }
                        
                        Divider()
                            .background(Color.common.Divider.default)
                    }
                }
            }
            .background(Color.timeTableMain.bottomSheet)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            
            
            Spacer()
                .frame(height: 20.adjusted)
            
            Button {
                viewModel.send(.reportButtonDidTap)
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
        .onAppear {
            Analytics.shared.track(.screenView("module_info_setting", .bottom_sheet))
        }
    }
}
