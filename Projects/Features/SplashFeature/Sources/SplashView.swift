import SwiftUI

import BaseFeatureDependency
import DSKit

public struct SplashView: View {
    
    @EnvironmentObject var container: DIContainer
    var viewModel: SplashViewModel
    
    public init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            Image(uiImage: .logo)
                .resizable()
                .frame(height: 74)
                .padding(.horizontal, 124)
                .padding(.bottom, 12)
            
            Text("School life in My Hands")
                .font(.semibold_18)
                .foregroundColor(.heyMain)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                viewModel.send(.goToOnboarding)
            }
        }
        .transition(.opacity)
    }
}
