
import SwiftUI

struct UserInfoView: View {

    @Environment(\.presentationMode) var presentationMode
    @StateObject var userViewModel: UserViewModel
    let email = UserDefaults.standard.value(forKey: "userEmail")
    @State var modal: ModalType? = nil
    
    var body: some View {
        VStack {
            Text("Мои данные")
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding()
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
            TextFieldView(text: $userViewModel.userSurname, placeholder: "Фамилия")
                .disableAutocorrection(true)
//                .autocorrectionDisabled()
                .onTapGesture {
                    hideKeyboard()
                }
            TextFieldView(text: $userViewModel.userName, placeholder: "Имя")
//                .autocorrectionDisabled()
                .disableAutocorrection(true)

                .onTapGesture {
                    hideKeyboard()
                }
            TextFieldView(text: $userViewModel.userPhone, placeholder: "Телефон")
                .keyboardType(.phonePad)
                .onTapGesture {
                    hideKeyboard()
                }
            Button {
                UserDefaults.standard.set(userViewModel.userName, forKey: userViewModel.nameKey)
                UserDefaults.standard.set(userViewModel.userSurname, forKey: userViewModel.surNameKey)
                UserDefaults.standard.set(userViewModel.userPhone, forKey: userViewModel.numberPhoneKey)

                userViewModel.showUserInfoView = false

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

            for item in userViewModel.user {
                if email as! String == item.userEmail {
                    userViewModel.userName = item.userName
                    userViewModel.userSurname = item.userSurname
                    userViewModel.userPhone = item.userPhone
                }
            }
        }
    }
}
