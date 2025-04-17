import SwiftUI
import Combine

@available(iOS 15, *)
public struct SecurityCodeInputView: View {

    // MARK: - Focus Field
    enum FocusField: Hashable {
        case field
    }

    @FocusState private var focusedField: FocusField?
    @Binding var otpCode: String

    // MARK: - Init
    public init(otpCode: Binding<String>) {
        self._otpCode = otpCode
    }

    // MARK: - Body
    public var body: some View {
        HStack {
            ZStack(alignment: .center) {
                TextField("", text: $otpCode)
                    .frame(width: 0, height: 0)
                    .accentColor(.clear)
                    .foregroundColor(.clear)
                    .multilineTextAlignment(.center)
                    .keyboardType(.numberPad)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                    .focused($focusedField, equals: .field)
                    .onAppear {
                        DispatchQueue.main.async {
                            keyBoardAppear()
                        }
                    }
                    .onChange(of: otpCode) { newValue in
                        let numbersOnly = newValue.filter { $0.isNumber }

                        // 6자리 정확히 입력 시 키보드 내림
                        if numbersOnly.count == 6 {
                            otpCode = numbersOnly
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        // 초과 시 자르기
                        else if numbersOnly.count > 6 {
                            otpCode = String(numbersOnly.prefix(6))
                            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                        }
                        // 문자 입력 제거
                        else if newValue != numbersOnly {
                            DispatchQueue.main.async {
                                otpCode = numbersOnly
                            }
                        }

                        // 빈 경우 키보드 다시 띄움
                        if otpCode.isEmpty {
                            keyBoardAppear()
                        }
                    }
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

    // MARK: - Helpers
    private func getPin(at index: Int) -> String {
        guard self.otpCode.count > index else {
            return ""
        }
        return self.otpCode[index]
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
