import SwiftUI
import BaseFeatureDependency

public struct SplashView: View {
    
    @EnvironmentObject var router: Router
    var viewModel: SplashViewModel
    
    public init(viewModel: SplashViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack {
            Button {
                viewModel.send(.buttonDidTap)
            } label: {
                Text("SignUp")
            }
        }
    }
}
