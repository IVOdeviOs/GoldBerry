import FirebaseAuth
import FirebaseCore
import SwiftUI

struct LoginView: View {
    @ObservedObject var signUP: LogIn
    var body: some View {
        GeometryReader { _ in
            VStack {
                Spacer()
                Text("GoldBerry")
                    .font(.title)
                    .foregroundColor(Color.yellow)
                    .padding(.all, 30)
                    .background(Color(red: 1 / 255,
                                      green: 50 / 255,
                                      blue: 32 / 255,
                                      opacity: 1))
                    .clipShape(Capsule())
                    .aspectRatio(contentMode: .fill)
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
