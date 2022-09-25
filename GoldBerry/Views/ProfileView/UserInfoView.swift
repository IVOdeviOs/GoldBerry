import SwiftUI

struct UserInfoView: View {
    
    @StateObject var viewModel: FruitViewModel
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
            TextFieldView(text: $userSurname, placeholder: "Фамилия",text1: "")
                .onTapGesture {
                            hideKeyboard()
                    }
            TextFieldView(text: $userName, placeholder: "Имя",text1: "")
                .onTapGesture {
                            hideKeyboard()
                    }
            TextFieldView(text: $userPhone, placeholder: "Телефон",text1: "")
                .keyboardType(.numberPad)
                .onTapGesture {
                            hideKeyboard()
                    }
            TextFieldView(text: $userEmail, placeholder: "E-mail",text1: "")
                .keyboardType(.emailAddress)
                .onTapGesture {
                            hideKeyboard()
                    }
            Button {
                viewModel.user.userSurname = userSurname
                viewModel.user.userName = userName
                viewModel.user.userPhone = userPhone
                viewModel.user.userEmail = userEmail
                ProfileView(viewModel: viewModel)
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
            viewModel: FruitViewModel(),
            userName: "",
            userSurname: "",
            userPhone: "",
            userEmail: ""
        )
    }
}


