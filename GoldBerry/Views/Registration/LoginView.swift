import FirebaseAuth
import FirebaseCore
import SwiftUI

struct LoginView: View {
    @ObservedObject var signUP: LogIn
    @ObservedObject var fruitViewModel: FruitViewModel
    @Environment(\.presentationMode) var presentation

    var body: some View {
        VStack {
            GeometryReader { _ in
                VStack {
                    HStack {
                        Button {
                            self.presentation.wrappedValue.dismiss()
                            fruitViewModel.presentedAuth = false
                            fruitViewModel.alertFavorite = false
                            fruitViewModel.showAuth = false
                            fruitViewModel.showAuthCartView = false
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
                    Text("Доставка фруктов")
                        .offset(y: -20)
                        .multilineTextAlignment(.center)
                        .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                        .foregroundColor(Color.theme.green4)
                    Spacer()
                    ZStack {
                        SignUP(index: $signUP.index, show: .constant(false), fruitViewModel: fruitViewModel)
                            .zIndex(Double(signUP.index))
                        Login(fruitViewModel: fruitViewModel, index: $signUP.index)
                    }
                    .offset(y: -70)
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                    .padding(.horizontal, 10)
                }
            }
            .background(Color.theme.background)
        }
    }
}
