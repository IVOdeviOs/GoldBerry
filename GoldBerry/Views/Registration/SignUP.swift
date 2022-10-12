import Combine
import FirebaseAuth
import FirebaseCore
import SwiftUI
import CoreData

struct SignUP: View {

    @StateObject private var signUP = LogIn()
    @Binding var index: Int
    @Binding var show: Bool
    
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: UserRegEntity.entity(), sortDescriptors: [])
    var users: FetchedResults<UserRegEntity>
    
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    Spacer(minLength: 0)
                    VStack(spacing: 10) {
                        Text("SignUp")
                            .foregroundColor(index == 1 ? .white : Color.theme.gray)
                            .font(Font(uiFont: .fontLibrary(22, .uzSansBold)))
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
                            .foregroundColor(Color.white)
                        TextField("Email Address", text: $signUP.email)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                            .foregroundColor(.white)
                            .autocapitalization(.none)
                            .keyboardType(.emailAddress)
                    }
                    Divider()
                        .background(Color.white)
                }
                .padding(.horizontal)
                .padding(.top, 30)

                VStack {
                    HStack(spacing: 15) {
                        Button {
                            signUP.secure.toggle()
                        } label: {
                            Image(systemName: signUP.secure ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.white)
                        }
                        if signUP.secure {
                            SecureField("Password", text: $signUP.password)
                                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        } else {
                            TextField("Password", text: $signUP.password)
                                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        }
                    }
                    Divider()
                        .background(Color.white)
                }
                .padding(.horizontal)
                .padding(.top, 30)
                VStack {
                    HStack(spacing: 15) {
                        Button {
                            signUP.secureConfirm.toggle()
                        } label: {
                            Image(systemName: signUP.secureConfirm ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.white)
                        }
                        if signUP.secureConfirm {
                            SecureField("Password", text: $signUP.confirmationPassword)
                                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        } else {
                            TextField("Password", text: $signUP.confirmationPassword)
                                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        }
                    }
                    Divider()
                        .background(Color.white)
                }
                .padding(.horizontal)
                .padding(.top, 30)

                HStack {
                    Text(" I agree to the assessment,\n use and processing of my personal data")
                        .foregroundColor(.white)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        
                        .lineLimit(2)
                    Spacer()
                    Button {
                        signUP.terms.toggle()
                    } label: {
                        Image(systemName: signUP.terms ? "square.fill" : "square")
                            .foregroundColor(Color.white)
                            .padding()
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
                        UserDefaults.standard.set(signUP.email, forKey: "userEmail")

//                        addUser()
                        UserDefaults.standard.set(true, forKey: "status")
                        show.toggle()
                        NotificationCenter.default.post(name: NSNotification.Name("statusChange"), object: nil)
//                        UserDefaults.standard.set(signUP.email, forKey: "1")
                    }
                }
            } label: {

                Text("SignUp")
                    .foregroundColor(.white)
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
    func addUser() {
        withAnimation {
            let newUser = UserRegEntity(context: viewContext)
            newUser.email = signUP.email
            for i in users{
                if newUser.email == i.email{
                    viewContext.delete(newUser)
                }
            }

            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}

struct SignUP_Previews: PreviewProvider {
    static var previews: some View {
        SignUP(index: .constant(0), show: .constant(true))
    }
}
