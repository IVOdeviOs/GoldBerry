import FirebaseAuth
import FirebaseCore
import SwiftUI

struct Login: View {
    @StateObject private var login = LogIn()
//    @ObservedObject var userViewModel = LogIn()
    @Binding var index: Int
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: UserRegEntity.entity(), sortDescriptors: [])
    var users: FetchedResults<UserRegEntity>
    @State var showForGetPassword = false
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                HStack {
                    VStack(spacing: 10) {
                        Text("LogIn")
                            .foregroundColor(index == 0 ? Color.theme.background : .gray)
                            .font(Font(uiFont: .fontLibrary(22, .uzSansBold)))
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
                            .foregroundColor(Color.theme.background)
                        TextField("Email address", text: $login.email)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                            .foregroundColor(Color.theme.background)
                            .keyboardType(.emailAddress)
                    }
                    Divider()
                        .background(Color.theme.background)
                }
                .padding(.horizontal)
                .padding(.top, 40)

                VStack {
                    HStack(spacing: 15) {
                        Button {
                            login.secure.toggle()
                        } label: {
                            Image(systemName: login.secure ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(Color.theme.background)
                        }
                        if login.secure {
                            SecureField("Password", text: $login.password)
                                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                                .foregroundColor(Color.theme.background)
                        } else {
                            TextField("Password", text: $login.password)
                                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                                .foregroundColor(Color.theme.background)
                        }
                    }

                    Divider()
                        .background(Color.theme.background)
                }
                .padding(.horizontal)
                .padding(.top, 50)

                HStack {
                    Spacer(minLength: 0)
                    Button {
//                        forGetPassword(email: login.email)
                        self.showForGetPassword.toggle()
                    } label: {
                        Text("Forget Password?")
                            .foregroundColor(Color.theme.background)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
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
            .shadow(color: Color.black.opacity(0.3),
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
                        UserDefaults.standard.set(login.email, forKey: "userEmail")
                        UserDefaults.standard.set(true, forKey: "status")
                        NotificationCenter.default
                            .post(name: NSNotification.Name("statusChange"), object: nil)
                    }
                }
            } label: {
                Text("LogIn")
                    .foregroundColor(Color.theme.background)
                    .font(Font(uiFont: .fontLibrary(18, .uzSansSemiBold)))
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
            .sheet(isPresented: $showForGetPassword) {
                ForGetPasswordView()
            }
        }
    }

    func addUser() {
        withAnimation {
            let newUser = UserRegEntity(context: viewContext)
            newUser.email = login.email
            for i in users {
                if newUser.email == i.email {
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
