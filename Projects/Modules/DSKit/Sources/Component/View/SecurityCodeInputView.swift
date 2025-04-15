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
                    .accentColor(.clear)
                    .foregroundColor(.clear)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .onChange(of: otpCode) { _ in
                        print(otpCode)
                        if otpCode.isEmpty { keyBoardAppear() }
                        if otpCode.count >= 6 {
                            otpCode = String(otpCode.prefix(6))
                            
                            endTextEditing()
                        }
                    }
                    .focused($focusedField, equals: .field)
                    .task { keyBoardAppear() }
                    .padding()
                
                HStack(spacing: 0) {
                    
                    ForEach(0..<6) { index in
                        VStack {
                            Text(self.getPin(at: index))
                                .font(.semibold_28)
                                .foregroundColor(.common.MainText.default)
                            Rectangle()
                                .frame(width: 32, height: 2)
                                .foregroundColor(.common.InputField.securityCode)
                                .padding(.leading, index == 3 ? 20 : 10)
                                .padding(.trailing, index == 2 ? 20 : 10)
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
    
    private func keyBoardAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.focusedField = .field
        }
    }
}


extension String {
    subscript(idx: Int) -> String {
        String(self[index(startIndex, offsetBy: idx)])
    }
}

