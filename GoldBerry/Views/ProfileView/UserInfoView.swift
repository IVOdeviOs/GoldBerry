import SwiftUI

struct UserInfoView: View {
//    @FetchRequest(entity: UserRegEntity.entity(), sortDescriptors: [])
//    var users: FetchedResults<UserRegEntity>
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: FruitViewModel
//    @State var userName: String
//    @State var userSurname: String
//    @State var userPhone: String
//    @State var userEmail = ""
    let email = UserDefaults.standard.value(forKey: "userEmail")
    @State var modal: ModalType? = nil

    var body: some View {
        VStack {
            Text("Мои данные")
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .foregroundColor(.black)
                .padding()
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
            TextFieldView(text: $viewModel.userSurname, placeholder: "Фамилия")
                .onTapGesture {
                    hideKeyboard()
                }
            TextFieldView(text: $viewModel.userName, placeholder: "Имя")
                .onTapGesture {
                    hideKeyboard()
                }
            TextFieldView(text: $viewModel.userPhone, placeholder: "Телефон")
                .keyboardType(.numberPad)
                .onTapGesture {
                    hideKeyboard()
                }
//            TextFieldView(text: $userEmail, placeholder: "E-mail")
//                .keyboardType(.emailAddress)
//                .onTapGesture {
//                            hideKeyboard()
//                    }
            Button {

                viewModel.user.forEach { i in
                    if i.userEmail == email as! String {
                        Task {
                            do {
                                try await viewModel.updateUser()
                            } catch {
                                print("❌ ERORR🥰")
                            }
                        }
//                        modal = .update(User(id:viewModel.userId, userName: viewModel.userName, userSurname: viewModel.userSurname, userPhone: viewModel.userPhone, userEmail: email as! String))

                    } else {
                        Task {
                            do {
                                try await viewModel.addUser()
                            } catch {
                                print("❌ ERORR😤")
                            }
                        }
                    }
                }

//                modal = .update(User(userName: viewModel.userName, userSurname: viewModel.userSurname, userPhone: viewModel.userPhone, userEmail: email as! String))

                //                userEmail = email as! String
//
//                let use = User(userName: userName,
//                               userSurname: userSurname,
//                               userPhone: userPhone,
//                               userEmail: userEmail)

//                Task {
//                    do {
//                        try await viewModel.addUser()
//                    } catch {
//                        print("❌ ERORR")
//                    }
//                }
                self.viewModel.showUserInfoView = false
//                viewModel.users.userSurname = userSurname
//                viewModel.users.userName = userName
//                viewModel.users.userPhone = userPhone
//                viewModel.user.userEmail = userEmail
//                ProfileView(viewModel: viewModel)
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
        }.onAppear {

            for item in viewModel.user {
                if email as! String == item.userEmail {
                    viewModel.userName = item.userName
                    viewModel.userSurname = item.userSurname
                    viewModel.userPhone = item.userPhone
                }
            }
        }
    }
}

struct UserInfoView_Previews: PreviewProvider {
    static var previews: some View {
        UserInfoView(
            viewModel: FruitViewModel()
//            userName: "",
//            userSurname: "",
//            userPhone: "",
//            userEmail: ""
        )
    }
}
