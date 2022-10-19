import FirebaseAuth
import FirebaseCore
import SwiftUI

struct LoginView: View {
    @ObservedObject var signUP: LogIn
    var body: some View {
        VStack {
            GeometryReader { _ in
                VStack {
                    Image("goldBerryLogo")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .padding()
                    Text("Доставка фруктов по Минску")
                        .offset(y: -20)
                        .multilineTextAlignment(.center)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                        .foregroundColor(Color.theme.lightGreen)
                    Spacer()
                    ZStack {
                        SignUP(index: $signUP.index, show: .constant(false))
                            .zIndex(Double(signUP.index))
                        Login(index: $signUP.index)
                    }
                    .offset(y: -100)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .padding(.horizontal, 10)
                }
            }
            .background(Color.theme.background)
        }
    }
}
