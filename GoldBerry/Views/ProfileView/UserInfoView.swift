
import iPhoneNumberField
import SwiftUI
struct UserInfoView: View {

    @Environment(\.presentationMode) var presentationMode
    @StateObject var userViewModel: UserViewModel
    let email = UserDefaults.standard.value(forKey: "userEmail")

    var body: some View {
        VStack {
            Text("Мои данные")
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding()
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
            TextFieldView(text: $userViewModel.userSurname, placeholder: "Фамилия", infoText: "")
                .disableAutocorrection(true)
                .onTapGesture {
                    HideKeyboard()
                }
            TextFieldView(text: $userViewModel.userName, placeholder: "Имя", infoText: "")
                .disableAutocorrection(true)
                .onTapGesture {
                    HideKeyboard()
                }
            ZStack(alignment: .leading) {
                Text("+375")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(18, .uzSansRegular)))
                    .padding(.leading, 30)
                    .padding(.top, 4)
                iPhoneNumberField("Телефон", text: $userViewModel.userPhone)
                    .maximumDigits(9)
                    .defaultRegion("BY")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                    .padding(.leading, 55)
                    .background(.clear)
                    .frame(height: 50)
                    .keyboardType(.numberPad)
                    .disableAutocorrection(true)
                    .onTapGesture {
                        HideKeyboard()
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.theme.blackWhiteText, lineWidth: 1)
                    )
                    .padding()
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
                if email as? String ?? "error" == item.userEmail {
                    userViewModel.userName = item.userName
                    userViewModel.userSurname = item.userSurname
                    userViewModel.userPhone = item.userPhone
                }
            }
        }
    }
}
