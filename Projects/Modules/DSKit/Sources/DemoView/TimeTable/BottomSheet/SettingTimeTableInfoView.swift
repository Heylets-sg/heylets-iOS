import SwiftUI

struct SettingTimeTableInfoView: View {
    @State private var isShowingSelectInfoView: Bool = false
    
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
                    isShowingSelectInfoView.toggle()  // 버튼 클릭 시 선택 뷰 토글
                } label: {
                    Text("Module code, Class room, Professor")
                        .font(.regular_12)
                        .foregroundColor(.heyGray2)
                }
                
                Spacer()
            }
            .padding(.leading, 24)
            
            Spacer()
        }
        .sheet(isPresented: $isShowingSelectInfoView) {
            ModuleSelectionView(isShowingSelectInfoView: $isShowingSelectInfoView)
                .background(TransparentBackground()) // 투명한 배경을 추가
                .transition(.move(edge: .bottom))
                .presentationDetents([.medium, .large, .height(400)])
                .presentationDragIndicator(.hidden)
        }
    }
}

// 배경을 투명하게 설정하는 뷰
struct TransparentBackground: View {
    var body: some View {
        Color.clear
            .edgesIgnoringSafeArea(.all)
    }
}

struct ModuleSelectionView: View {
    @Binding var isShowingSelectInfoView: Bool
    private let options = [
        "module code",
        "module code, class room",
        "module code, class room, professor",
        "module code, professor"
    ]
    
    var body: some View {
        ZStack {
            Color.clear
            
            VStack {
                VStack(spacing: 0) {
                    ForEach(options, id: \.self) { option in
                        VStack {
                            HStack {
                                Spacer()
                                
                                Text(option)
                                    .font(.body)
                                
                                Spacer()
                            }
                            .padding(.vertical, 18)
                            .onTapGesture {
                                withAnimation {
                                    isShowingSelectInfoView.toggle()
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
                    isShowingSelectInfoView.toggle()  // 선택 후 뷰 닫기
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

//struct SettingTimeTableInfoView_Previews: PreviewProvider {
//    static var previews: some View {
//        SettingTimeTableInfoView()
//    }
//}
