import SwiftUI

struct AuthAdminView: View {
    @ObservedObject var adminViewModel: AdminViewModel
    @State var show = false
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
                        try await adminViewModel.fetchUser()
                        UserDefaults.standard.set(true, forKey: "statusAdmin")
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
        }
        
    }
}
