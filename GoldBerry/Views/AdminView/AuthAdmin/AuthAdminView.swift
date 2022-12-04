import SwiftUI

struct AuthAdminView: View {
    @ObservedObject var adminViewModel: AdminViewModel
    @State var show = false
    @State var order = Order(orderNumber: "", date: "", dateOrder: "", email: "", fruits: [Fruit(cost: 1, weightOrPieces: "", categories: "", favorite: false, count: 1, image: "", name: "", percent: 1, price: 1, comment: "", stepCount: 1, isValid: true)], address: "", price: 2, customer: "", customerPhone: "", comment: "", orderCompleted: false)
    var body: some View {
        VStack{
            Text("Вход для администраторов")
                .font(Font(uiFont: .fontLibrary(25, .uzSansLight)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.top,60)
            Spacer()
            TextFieldView(text: $adminViewModel.loginAdmin, placeholder: "Email", infoText: "Введите ваш Email")
                .disableAutocorrection(true)
                .autocapitalization(.none)

            TextFieldView(text: $adminViewModel.passwordAdmin, placeholder: "Password", infoText: "Введите ваш пароль")
                .disableAutocorrection(true)
                .autocapitalization(.none)
            Spacer()
            
            Button {
                Task{
                    do{
//                        let urlString = Constants.baseURL + EndPoints.adminOrder
//                        guard URL(string: urlString) != nil else {
//                            throw HttpError.badURL
//                        }
//                        try await  adminViewModel.sendData(to:url ,object: order, httpMethod: HttpMethods.POST.rawValue)
                        try await adminViewModel.fetchUser()

//                        if adminViewModel.statusAdmin == true {
//                            self.show.toggle()
//                        } else {
//                            print("Opppppsss")
//                        }
                    }catch{
                        
                    }
                }
            } label: {
                Text("Войти как администратор")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                    .background(Color.orange)
                    .cornerRadius(10)
                    .padding(.bottom, 150)
            }
            .fullScreenCover(isPresented: $show) {
                ProductView()
            }
        }
        
    }
}
