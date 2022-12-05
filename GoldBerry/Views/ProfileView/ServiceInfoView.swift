import SwiftUI

struct ServiceInfoView: View {
    @ObservedObject var adminViewModel = AdminViewModel()

    @Environment(\.presentationMode) var presentation
    @State var showDeliveryInfoView = false
    @State var showConfidentialView = false
    @State var showDisclaimerOfLiability = false
    @State var showContacts = false
    @State var showAdminProfile = false
    @State var login = UserDefaults.standard.object(forKey: "userEmail")
    var numberPhone = "+375297023701"
    func checkLogin() -> Bool {
        for item in adminViewModel.userLogin {
            if item.login == login as? String {
                return true
            }
        }
        return false
    }

    var body: some View {
        VStack {
            Text("О сервисе")
                .foregroundColor(Color.theme.blackWhiteText)
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .padding()
                .offset(y: -100)
            ZStack {
                Color.theme.grayWhite
                    .opacity(0.2)
                    .frame(height: 200)
                VStack {
                    Text("Версия 2.0")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .opacity(0.5)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                        .padding(.bottom, 5)
                    Text("\u{24B8} 2022 DMTeam")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .opacity(0.5)
                }
            }
            List {
                Button {
                    self.showDeliveryInfoView.toggle()
                }
            label: {
                    HStack {
                        Text("Оплата и доставка")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(Color.theme.blackWhiteText)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width:8, height: 8)
                            .foregroundColor(.gray)
                    }
                    .sheet(isPresented: $showDeliveryInfoView, content: {
                        DeliveryInfoView()
                    })
                }

                Button {
                    self.showConfidentialView.toggle()
                }
            label: {
                    HStack {
                        Text("Положение о конфиденциальности")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(Color.theme.blackWhiteText)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width:8, height: 8)
                            .foregroundColor(.gray)
                    }
                    .sheet(isPresented: $showConfidentialView, content: {
                        ConfidentialView()
                    })
                }

                Button {
                    self.showDisclaimerOfLiability.toggle()
                }
            label: {
                    HStack {
                        Text("Отказ от ответственности")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(Color.theme.blackWhiteText)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width:8, height: 8)
                            .foregroundColor(.gray)
                    }
                    .sheet(isPresented: $showDisclaimerOfLiability, content: {
                        DisclaimerOfLiability()
                    })
                }

                Button {
                    let formattedString = "tel://" + numberPhone
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)
                }
            label: {
                    HStack {
                        Text("Контакты")
                            .minimumScaleFactor(0.5)
                            .foregroundColor(Color.theme.blackWhiteText)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        Spacer()
                        Image(systemName: "chevron.right")
                            .resizable()
                            .frame(width:8, height: 8)
                            .foregroundColor(.gray)
                    }
                }
                if checkLogin(){
                    
                    NavigationLink {
                        if adminViewModel.statusAdmin {
                            ProductView()
                                .navigationBarHidden(true)
                        } else {
                            AuthAdminView(adminViewModel: adminViewModel)
                        }
                    } label: {
                        HStack {
                            Text("Вход для администратора")
                                .minimumScaleFactor(0.5)
                                .foregroundColor(Color.theme.blackWhiteText)
                                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                            Spacer()
//                            Image(systemName: "arrow.right")
//                                .resizable()
//                                .frame(width: 15, height: 15)
//                                .foregroundColor(Color.theme.blackWhiteText)
                        }
                    }
                }
//                Button {
//
//                    self.showAdminProfile.toggle()
//                }
//            label: {
//                    HStack {
//                        Text("Вход для администратора")
//                            .minimumScaleFactor(0.5)
//                            .foregroundColor(Color.theme.blackWhiteText)
//                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
//                        Spacer()
//                        Image(systemName: "arrow.right")
//                            .resizable()
//                            .frame(width: 15, height: 15)
//                            .foregroundColor(Color.theme.blackWhiteText)
//                    }
//                }
//                .sheet(isPresented: $showAdminProfile, content: {
//                    AuthAdminView(adminViewModel: adminViewModel)
//                })
            }
            .offset(y: -15)
            .listStyle(.plain)
            Link(destination: URL(string: "https://www.instagram.com/nar_juice")!) {
                Image("instagram")
                    .resizable().frame(width: 60, height: 60).padding()
            }
            Spacer()
        }
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                switch value.translation.width {
                case 100 ... 300: self.presentation.wrappedValue.dismiss()
                default: print("no clue")
                }
            }
        )
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Image(systemName: "arrow.backward")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color.theme.blackWhiteText)
                .onTapGesture {
                    self.presentation.wrappedValue.dismiss()
                }
        )
        .onAppear {
            Task {
                do {
                    try await adminViewModel.fetchUserLogin()
                } catch {}
            }
        }
    }
}
