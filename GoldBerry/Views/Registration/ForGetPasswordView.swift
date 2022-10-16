import SwiftUI

struct ForGetPasswordView: View {
    @State var email = ""
    @State var show = false
    var body: some View {
        ZStack {

            Color.white
                .ignoresSafeArea(edges: .all)
            VStack {
                VStack(spacing: 20) {
                    TextFieldView(text: $email, placeholder: "Введите почту")
                }
                .padding()
                .padding(.bottom, 8.0)
                VStack(spacing: 16) {
                    Button {
                        forGetPassword(email: email)
                        self.show.toggle()
                    } label: {
                        Text("Восстановление пароля")
                            .frame(maxWidth: .infinity)
                            .font(.title2)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.red)
                    .cornerRadius(16)
                }
                .padding()

                Spacer()
            }
            .padding(.top, 300)
        }
        .alert(isPresented: $show) {
            Alert(title: Text(""), message: Text("Письмо отправлено на указанную почту,оно так же может находиться в папке спам "), dismissButton: .default(Text("Ok")))
        }
        .navigationTitle("Восстановление пароля")
    }
}

struct ForGetPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForGetPasswordView()
    }
}
