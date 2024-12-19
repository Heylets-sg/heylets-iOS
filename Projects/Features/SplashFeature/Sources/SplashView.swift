import SwiftUI
import BaseFeatureDependency

public struct SplashView: View {
    
    @EnvironmentObject var router: Router
    
    public init() {}
    
    public var body: some View {
        VStack {
            Text("Splash View")
        }
    }
}
