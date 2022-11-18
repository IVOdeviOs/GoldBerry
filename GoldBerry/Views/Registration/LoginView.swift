import FirebaseAuth
import FirebaseCore
import SwiftUI

struct LoginView: View {
    @ObservedObject var signUP: LogIn
    @ObservedObject var fruitViewModel: FruitViewModel
    var body: some View {
        VStack {
            GeometryReader { _ in
                VStack {
                    HStack {
                        Button {
                            fruitViewModel.presentedAuth = false
                            fruitViewModel.alertFavorite = false
                            fruitViewModel.showAuth = false
                        } label: {
                            Image(systemName: "arrow.backward")
                                .resizable()
                                .frame(width: 18, height: 18)
                                .foregroundColor(Color.theme.blackWhiteText)
                        }
                        .padding(.leading)
                        Spacer()
                        Image("goldBerryLogo")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .padding()
                        Spacer()
                    }
                    Text("Доставка фруктов по Минску")
                        .offset(y: -20)
                        .multilineTextAlignment(.center)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                        .foregroundColor(Color.theme.lightGreen)
                    Spacer()
                    ZStack {
                        SignUP(index: $signUP.index, show: .constant(false), fruitViewModel: fruitViewModel)
                            .zIndex(Double(signUP.index))
                        Login(fruitViewModel: fruitViewModel, index: $signUP.index)
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
