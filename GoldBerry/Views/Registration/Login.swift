import FirebaseAuth
import FirebaseCore
import SwiftUI

struct Login: View {
    @StateObject private var login = LogIn()
    @Binding var index: Int
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    VStack(spacing: 10) {
                        Text("Login")
                            .foregroundColor(index == 0 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        Capsule()
                            .fill(index == 0 ? Color(red: 243 / 255,
                                                     green: 122 / 255,
                                                     blue: 72 / 255) : .clear)
                            .frame(width: 100, height: 5)
                    }
                    Spacer()
                }
                .padding(.top, 30)
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(.gray)
                        TextField("Email adress", text: $login.email)
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 40)

                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "eye.slash.fill")
                            .foregroundColor(.gray)
                        SecureField("Password", text: $login.password)
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 50)

                HStack {
                    Spacer(minLength: 0)
                    Button {
                        //
                    } label: {
                        Text("Forget Password?")
                            .foregroundColor(Color.white.opacity(0.6))
                    }
                }
                .padding(.horizontal)
                .padding(.top, 30)
            }
            .padding()
            .padding(.bottom, 65)
            .background(Color.theme.backgroundMenu)
            .clipShape(CShape())
            .contentShape(CShape())
            .shadow(color: Color.green.opacity(0.3),
                    radius: 5,
                    x: 0,
                    y: -5)
            .onTapGesture {
                index = 0
            }
            .cornerRadius(35)

            Button {
                signInWithEmail(email: login.email, password: login.password) { verified, status in
                    if !verified {
                        login.message = status
                        login.alert.toggle()
                    } else {
                        UserDefaults.standard.set(true, forKey: "status")
                        NotificationCenter.default
                            .post(name: NSNotification.Name("statusChange"), object: nil)
                        UserDefaults.standard.set(login.email, forKey: "1")
                    }
                }
            } label: {
                Text("LogIn")
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(Color(red: 243 / 255,
                                      green: 122 / 255,
                                      blue: 72 / 255))
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1),
                            radius: 5,
                            x: 0,
                            y: 5)
            }
            .alert(isPresented: $login.alert) {
                Alert(title: Text("Error"), message: Text(login.message), dismissButton: .default(Text("Ok")))
            }
            .offset(y: 30)
            .opacity(index == 0 ? 1 : 0)
        }
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        Login(index: .constant(0))
    }
}
