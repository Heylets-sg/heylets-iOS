import SwiftUI

struct SettingTimeTableInfoView: View {
    
    @ObservedObject var viewModel: ThemeViewModel
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 30)
            
            HStack {
                Text("Information")
                    .font(.medium_14)
                    .foregroundColor(.heyGray1)
                
                Spacer()
                
                Button {
                    viewModel.send(.selectDisplayTypeButtonDidTap)
                } label: {
                    Text(viewModel.displayType.text)
                        .font(.regular_12)
                        .foregroundColor(.heyGray2)
                }
                
                Spacer()
            }
            .padding(.leading, 24)
            
            Spacer()
        }
        .sheet(isPresented: $viewModel.state.isShowingSelectInfoView) {
            SelectDisplayModuleView(viewModel: viewModel)
                .background(.clear) // 투명한 배경을 추가
                .transition(.move(edge: .bottom))
                .presentationDetents([.medium, .large, .height(400)])
                .presentationDragIndicator(.hidden)
        }
    }
}

struct SelectDisplayModuleView: View {
    private var viewModel: ThemeViewModel
    
    init(viewModel: ThemeViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Color.clear
            
            VStack {
                VStack(spacing: 0) {
                    ForEach(viewModel.options, id: \.self) { option in
                        VStack {
                            HStack {
                                Spacer()
                                
                                Text(option.text)
                                    .font(.body)
                                
                                Spacer()
                            }
                            .padding(.vertical, 18)
                            .onTapGesture {
                                withAnimation {
                                    viewModel.send(.selectDisplayType(option))
                                }
                            }
                            
                            Divider()
                                .background(Color.heyGray1)
                        }
                    }
                }
                .background(RoundedRectangle(cornerRadius: 10).strokeBorder(Color.gray, lineWidth: 1))
                
                Spacer()
                    .frame(height: 20)

                Button {
                    viewModel.send(.reportButtonDidTap)
                } label: {
                    Text("Report")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.heyWhite)
                        .foregroundColor(.heyGray1)
                        .cornerRadius(8)
                }
                
                Spacer()
                    .frame(height: 65)
            }
            .padding(.horizontal, 16)
            .background(Color.clear)
            .cornerRadius(12)
        }
    }
}
