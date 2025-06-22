import SwiftUI

import BaseFeatureDependency
import DSKit

public struct SplashView: View {
    
    @EnvironmentObject var container: Router
    var viewModel: SplashViewModel
    
    public init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                VStack {
                    Image.logo
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(
                            width: geometry.size.width * 0.44,
                            height: geometry.size.height * 0.1
                        )
                        .padding(.bottom, 12)
                    
                    Text("School life in My Hands")
                        .font(.semibold_16)
                        .foregroundColor(.heyMain)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .multilineTextAlignment(.center)  // 텍스트 중앙 정렬
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea()
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    viewModel.send(.onAppear)
                }
            }
            .transition(.opacity)
        }
    }
}
