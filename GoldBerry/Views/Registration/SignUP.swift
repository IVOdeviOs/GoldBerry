
import Combine
import FirebaseAuth
import FirebaseCore
import SwiftUI

struct SignUP: View {

    @StateObject private var signUP = LogIn()
    @Binding var index: Int
    @Binding var show: Bool

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    VStack(spacing: 10) {
                        Text("SignUp")
                            .foregroundColor(index == 1 ? .white : .gray)
                            .font(.title)
                            .fontWeight(.bold)
                        Capsule()
                            .fill(index == 1 ? Color(red: 243 / 255,
                                                     green: 122 / 255,
                                                     blue: 72 / 255) : .clear)
                            .frame(width: 100, height: 5)
                    }
                }
                .padding(.top, 30)
                VStack {
                    HStack(spacing: 15) {
                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color.gray)
                        TextField("Email Adrees", text: $signUP.email)
                            .autocapitalization(.none)
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)

                VStack {
                    HStack(spacing: 15) {
                        Button {
                            signUP.secure.toggle()
                        } label: {
                            Image(systemName: signUP.secure ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color.gray)
                        }
                        if signUP.secure {
                            SecureField("Password", text: $signUP.password)
                        } else {
                            TextField("Password", text: $signUP.password)
                        }
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)
                VStack {
                    HStack(spacing: 15) {
                        Button {
                            signUP.secureConfirm.toggle()
                        } label: {
                            Image(systemName: signUP.secureConfirm ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color.gray)
                        }
                        if signUP.secureConfirm {
                            SecureField("Password", text: $signUP.confirmationPassword)
                        } else {
                            TextField("Password", text: $signUP.confirmationPassword)
                        }
                    }
                    Divider()
                        .background(Color.white.opacity(0.5))
                }
                .padding(.horizontal)
                .padding(.top, 30)

                HStack {
                    Text(" I agree to the assessment, \n use and processing of my personal data")
                        .foregroundColor(.gray)
                        .font(Font.system(size: 12))
                        .lineLimit(2)
                    Spacer()
                    Button {
                        signUP.terms.toggle()
                    } label: {
                        Image(systemName: signUP.terms ? "square.fill" : "square")
                            .foregroundColor(Color.black)
                    }
                }
                .offset(y: 30)
            }
            .padding()
            .padding(.bottom, 65)
            .background(Color.theme.backgroundMenu)
            .clipShape(CShape1())
            .contentShape(CShape1())
            .shadow(color: Color.black.opacity(0.3),
                    radius: 5,
                    x: 0,
                    y: -5)
            .onTapGesture {
                index = 1
            }
            .cornerRadius(35)

            Button {
                signUpWithEmail(email: signUP.email,
                                password: signUP.password,
                                confirmPassword: signUP.confirmationPassword) { verified, status in
                    if !verified {
                        signUP.message = status
                        signUP.alert.toggle()
                    } else {
                        UserDefaults.standard.set(true, forKey: "status")
                        show.toggle()
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                        UserDefaults.standard.set(signUP.email, forKey: "1")
                    }
                }
            } label: {

                Text("SignUp")
                    .foregroundColor(.white)
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 50)
                    .background(signUP.isValid ? Color(red: 243 / 255,
                                                       green: 122 / 255,
                                                       blue: 72 / 255) : Color.gray)
                    .clipShape(Capsule())
                    .shadow(color: Color.white.opacity(0.1),
                            radius: 5,
                            x: 0,
                            y: -5)
            }
            .disabled(!signUP.isValid)

            .alert(isPresented: $signUP.alert) {
                Alert(title: Text("Error"), message: Text(signUP.message), dismissButton: .default(Text("Ok")))
            }
            .offset(y: 25)
            .opacity(index == 1 ? 1 : 0)
        }
        .onAppear {
            signUP.isFormValid
                .receive(on: RunLoop.main)
                .assign(to: \.signUP.isValid, on: self)
                .store(in: &signUP.cancellable)

        }
    }
}

struct SignUP_Previews: PreviewProvider {
    static var previews: some View {
        SignUP(index: .constant(0), show: .constant(true))
    }
}
