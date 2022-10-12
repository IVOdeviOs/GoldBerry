import FirebaseAuth
import FirebaseCore
import SwiftUI

struct LoginView: View {
    @ObservedObject var signUP: LogIn
    var body: some View {
        GeometryReader { _ in
            VStack {
                Image("goldBerryLogo")
                    .resizable()
                    .frame(width: 70, height: 70)
                    .padding()
                Text("Бесплатная супербыстрая доставка фруктов по Минску")
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                        .foregroundColor(Color.theme.lightGreen)
                Spacer()
                ZStack {
                    SignUP(index: $signUP.index, show: .constant(false))
                        .zIndex(Double(signUP.index))
                    Login(index: $signUP.index)
                }
                .padding(.horizontal, 10)
                Spacer()
            }
        }
        .background(Color.theme.background)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(signUP: LogIn())
    }
}
