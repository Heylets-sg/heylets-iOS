import SwiftUI
import Combine

@available(iOS 15, *)
public struct SecurityCodeInputView: View {
    
    //MARK: Fields
    enum FocusField: Hashable {
        case field
    }
    
    @FocusState private var focusedField: FocusField?
    @Binding var otpCode: String
    
    //MARK: Constructor
    public init(otpCode: Binding<String>) {
        self._otpCode = otpCode
    }
    
    //MARK: Body
    public var body: some View {
        HStack {
            ZStack(alignment: .center) {
                TextField("", text: $otpCode)
                    .frame(width: 0, height: 0, alignment: .center)
                    .font(Font.system(size: 0))
                    .accentColor(.clear)
                    .foregroundColor(.clear)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .onChange(of: otpCode) { newValue in
                        print(otpCode)
                        if otpCode.isEmpty {
                            self.focusedField = .field // otpCode가 비어 있으면 키보드 올리기
                        }
                        if otpCode.count >= 6 {
                            otpCode = String(otpCode.prefix(6))
                            
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                    }
                    .focused($focusedField, equals: .field)
                    .task {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)
                        {
                            self.focusedField = .field
                        }
                    }
                    .padding()
                HStack {
                    ForEach(0..<6) { index in
                        VStack {
                            Text(self.getPin(at: index))
                                .font(.semibold_28)
                                .foregroundColor(Color.heyGray1)
                            Rectangle()
                                .frame(height: 2)
                                .foregroundColor(Color.heyGray1)
                                .padding(.horizontal, 5)
                                .opacity(self.otpCode.count <= index ? 1 : 0)
                        }
                    }
                }
            }
        }
        .onTapGesture {
            self.focusedField = .field
        }
    }
}

extension SecurityCodeInputView {
    //MARK: func
    private func getPin(at index: Int) -> String {
        guard self.otpCode.count > index else {
            return ""
        }
        return self.otpCode[index]
    }
    
    private func limitText(_ upper: Int) {
        if otpCode.count > upper {
            otpCode = String(otpCode.prefix(upper))
            
        }
    }
}


extension String {
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
}

import SwiftUI

struct ContentView: View {
    @State var otpCode: String = ""
    
    var body: some View {
        VStack {
            Text("Enter OTP")
                .font(.headline)
                .padding(.bottom, 8)
            
            SecurityCodeInputView(otpCode: $otpCode)
                .frame(height: 50)
                .padding()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

