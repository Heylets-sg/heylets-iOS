import SwiftUI
import DSKit
import Domain

import Core

struct SettingTimeTableInfoView: View {
    @ObservedObject var viewModel: ThemeViewModel
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
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
                        .frame(
                            height: viewModel.state.inviteCodeViewHidden
                            ? 388.adjusted
                            : 306.adjusted
                        )
                        .background(
                            Color.timeTableMain.bottomSheet
                        )
                    }
                }
                .sheet(isPresented: $viewModel.state.isShowingSelectInfoView) {
                    SelectDisplayModuleView(viewModel: viewModel)
                        .presentationDetents([.height(350)])
                        .presentationDragIndicator(.hidden)
                        .presentationBackground(.clear)
                }
            }
            
            if viewModel.state.isShowingPopup {
                CongratulationPopupView(
                    okayButtonClosure: { viewModel.send(.popUpOkButtonDidTap) }
                )
                .background(viewModel.state.isShowingPopup ? Color.common.Background.opacity60 : Color.clear)
            }
        }
    }
}

struct CongratulationPopupView: View {
    var okayButtonClosure: (() -> Void)
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 231)
            VStack {
                ZStack {
                    VStack {
                        Text("Congratulations!")
                            .font(.bold_20)
                            .foregroundColor(.common.MainText.default)
                            .padding(.top, 69)
                            .padding(.bottom, 20)
                        
                        Text("3 themes have been\nunlocked")
                            .font(.medium_16)
                            .foregroundColor(.common.MainText.default)
                            .multilineTextAlignment(.center)
                            .padding(.bottom, 27)
                        
                        Button("Ok") {
                            okayButtonClosure()
                        }
                        .heyAlertButtonStyle(.primary, 52)
                        .padding(.bottom, 30)
                        .padding(.horizontal, 14)
                    }
                    .frame(height: 300)
                    .background(Color.popup.default)
                    .clipShape(RoundedRectangle(cornerRadius: 6.5))
                    .padding(.top, 102)
                    
                    VStack {
                        Image(uiImage: .congratulation)
                            .resizable()
                            .frame(width: 167, height: 151)
                            .padding(.bottom, 200)
                    }
                }
                .padding(.horizontal, 54)
                .frame(height: 350)
            }
            Spacer()
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
