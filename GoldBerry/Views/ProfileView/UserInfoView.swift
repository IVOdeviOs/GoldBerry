import SwiftUI

struct UserInfoView: View {
    
    @StateObject var viewModels: OrderViewModel
    @State var userName: String
    @State var userSurname: String
    @State var userPhone: String
    @State var userEmail: String
    
    var body: some View {
        VStack {
            Text("Мои данные")
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .foregroundColor(.black)
                .padding()
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
            TextFieldView(text: $userSurname, placeholder: "Фамилия")
                .onTapGesture {
                            hideKeyboard()
                    }
            TextFieldView(text: $userName, placeholder: "Имя")
                .onTapGesture {
                            hideKeyboard()
                    }
            TextFieldView(text: $userPhone, placeholder: "Телефон")
                .keyboardType(.numberPad)
                .onTapGesture {
                            hideKeyboard()
                    }
            TextFieldView(text: $userEmail, placeholder: "E-mail")
                .keyboardType(.emailAddress)
                .onTapGesture {
                            hideKeyboard()
                    }
            Button {
                viewModels.user.userSurname = userSurname
                viewModels.user.userName = userName
                viewModels.user.userPhone = userPhone
                viewModels.user.userEmail = userEmail
            } label: {
                ZStack {
                    Color.theme.lightGreen
                        .background(Color.theme.lightGreen)
                        .frame(width: 300, height: 50)
                        .cornerRadius(10)
                    Text("Сохранить")
                        .foregroundColor(.white)
                }
            }
            Spacer()
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(
            viewModels: OrderViewModel(),
            userName: "",
            userSurname: "",
            userPhone: "",
            userEmail: ""
        )
    }
}

extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
        UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
