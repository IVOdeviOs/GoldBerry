import Combine
import CoreData
import FirebaseAuth
import FirebaseCore
import SwiftUI

struct SignUP: View {
    @StateObject private var signUP = LogIn()
    @Binding var index: Int
    @Binding var show: Bool
    @ObservedObject var fruitViewModel: FruitViewModel
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    VStack(spacing: 10) {
                        Text("Регистрация")
                            .foregroundColor(index == 1 ? Color.theme.background : Color.theme.grafit)
                            .font(Font(uiFont: .fontLibrary(22, .pFBeauSansProSemiBold)))
                        Capsule()
                            .fill(index == 1 ? Color(red: 80 / 255,
                                                     green: 142 / 255,
                                                     blue: 54 / 255) : .clear)
                            .frame(width: 100, height: 5)
                    }
                }
                .padding(.top, 30)
                VStack {
                    HStack(spacing: 15) {

                        Image(systemName: "envelope.fill")
                            .foregroundColor(Color.theme.background)
                        TextField("E-mail", text: $signUP.email)
                            .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                            .foregroundColor(Color.theme.background)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    Divider()
                        .background(Color.theme.background)
                }
                .padding(.horizontal)
                .padding(.top, 30)

                VStack {
                    HStack(spacing: 15) {
                        Button {
                            signUP.secure.toggle()
                        } label: {
                            Image(systemName: signUP.secure ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color.theme.background)
                        }
                        if signUP.secure {
                            SecureField("Пароль минимум 6 символов", text: $signUP.password)
                                .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                                .foregroundColor(Color.theme.background)

                        } else {
                            TextField("Пароль минимум 6 символов", text: $signUP.password)
                                .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                                .foregroundColor(Color.theme.background)
                        }
                    }
                    Divider()
                        .background(Color.theme.background)
                }
                .padding(.horizontal)
                .padding(.top, 30)
                VStack {
                    HStack(spacing: 15) {
                        Button {
                            signUP.secureConfirm.toggle()
                        } label: {
                            Image(systemName: signUP.secureConfirm ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color.theme.background)
                        }
                        if signUP.secureConfirm {
                            SecureField("Повторите пароль", text: $signUP.confirmationPassword)
                                .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                                .foregroundColor(Color.theme.background)
                        } else {
                            TextField("Повторите пароль", text: $signUP.confirmationPassword)
                                .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                                .foregroundColor(Color.theme.background)
                        }
                    }
                    Divider()
                        .background(Color.theme.background)
                }
                .padding(.horizontal)
                .padding(.top, 30)

                HStack {
                    Text(" Соглашаюсь на обработку \n персональных данных")
                        .foregroundColor(Color.theme.background)
                        .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))

                        .lineLimit(2)
                    Spacer()
                    Button {
                        signUP.terms.toggle()
                    } label: {
                        Image(systemName: signUP.terms ? "square.fill" : "square")
                            .foregroundColor(Color.theme.background)
                            .padding(.bottom, 10)
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
                Task {
                    do {
//                        try await signUP.addOrder(users: LoginUser(login: signUP.email, password: signUP.password, role: ""), log: signUP.email, pass: signUP.password)
                        signUpWithEmail(email: signUP.email,
                                        password: signUP.password,
                                        confirmPassword: signUP.confirmationPassword) { verified, status in
                            if !verified {
                                signUP.message = status
                                signUP.alert.toggle()
                            } else {
                                UserDefaults.standard.set(signUP.email, forKey: "userEmail")
                                UserDefaults.standard.set(signUP.password, forKey: "userPassword")
                                UserDefaults.standard.set(true, forKey: "status")
                                fruitViewModel.showAuth = false
                                fruitViewModel.presentedAuth = false
                                fruitViewModel.alertFavorite = false
                                fruitViewModel.showAuthCartView = false
                                show.toggle()
                                NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
                            }
                        }

                    } catch {
                        signUP.alert.toggle()
                    }
                }

            } label: {

                Text("Sign Up")
                    .foregroundColor(Color.theme.background)
                    .font(Font(uiFont: .fontLibrary(18, .uzSansSemiBold)))
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
                Alert(title: Text("Error"), message: Text("The email address or password is incorrect, or the user is already registered!"), dismissButton: .default(Text("Ok")))
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
