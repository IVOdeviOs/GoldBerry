import SwiftUI

struct ForGetPasswordView: View {
    @State var email = ""
    @State var show = false
    var body: some View {
        VStack {
            VStack {
                Text("Введите e-mail адрес")
                    .font(Font(uiFont: .fontLibrary(24, .uzSansBold)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .padding()
                TextFieldView(text: $email, placeholder: "E-mail")
                    .padding()
                    .padding(.bottom, 8.0)
                Spacer()
                Button {
                    forGetPassword(email: email)
                    self.show.toggle()
                } label: {

                    Text("Восстановить пароль")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 60, height: 50)
                        .background(Color.theme.lightGreen)
                        .cornerRadius(10)
                        .padding(.bottom, 50)
                }
                .padding()
            }
            .padding(.top, 100)
        }
        .confirmationDialog(Text(""), isPresented: $show, actions: {
            Button {
                if let url = URL(string: "googlegmail://") {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            } label: {
                Text("Ok")
            }

        }, message: {
            Text("Письмо отправлено на указанную почту,оно так же может находиться в папке спам ")
        })
        .navigationTitle("Восстановление пароля")
    }
}
