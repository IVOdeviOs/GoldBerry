import SwiftUI

struct ProfileView: View {
    @ObservedObject var fruitViewModel = FruitViewModel()
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var userViewModel = UserViewModel()

    @FetchRequest(entity: UserRegEntity.entity(), sortDescriptors: [])
    var users: FetchedResults<UserRegEntity>

    var body: some View {
        VStack {
            ZStack {
                Color.theme.lightGreen
                    .frame(height: 240)
                    .offset(y: -50)
                HStack {
                    VStack {
                        Text(userViewModel.userName.isEmpty && userViewModel.userSurname.isEmpty ? "Имя Фамилия" : "\(userViewModel.userName) \(userViewModel.userSurname)")
                            .foregroundColor(.white)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                            .padding()
                    }
                    Spacer()
                    Button {
                        userViewModel.showUserInfoView.toggle()
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }
                    .sheet(isPresented: $userViewModel.showUserInfoView, content: {
                        UserInfoView( userViewModel: userViewModel)
                    })
                }
            }
            ZStack {
                Button {
                    fruitViewModel.selected = 2
                } label: {
                    ZStack {
                        Color.white
                            .frame(width: 120, height: 70)
                            .cornerRadius(10)
                            .shadow(color: .gray, radius: 2, x: 1, y: 1)
                        VStack {
                            Text("Архив заказов")
                                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                                .foregroundColor(.black)
                                .padding(.bottom, 5)
                            Text("\(userViewModel.countOrder)")
                                .font(Font(uiFont: .fontLibrary(24, .uzSansSemiBold)))
                                .foregroundColor(.black)
                        }
                    }
                }
                .offset(x: -110, y: -80)
            }
            Button {
                userViewModel.showShopView.toggle()
            } label: {
                ZStack {
                    Color.theme.gray
                        .frame(height: 50)
                        .opacity(0.2)
                    HStack {
                        Text("Адреса торговых точек")
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                    }
                    .sheet(isPresented: $userViewModel.showShopView, content: {
                        ShopsView(viewModel: fruitViewModel)
                    })
                }
            }
            Button {
                userViewModel.showFavouriteProductsView.toggle()
            } label: {
                ZStack {
                    Color.theme.gray
                        .frame(height: 50)
                        .opacity(0.2)
                    HStack {
                        Text("Избранные товары")
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                            .padding(.leading, 15)
                        Spacer()
                        ZStack {
                            if !userViewModel.favouriteProducts.isEmpty {
                                Color.red
                                    .frame(width: 20, height: 20)
                                    .cornerRadius(10)
                                Text("\(userViewModel.favouriteProducts.count)")
                                    .minimumScaleFactor(0.5)
                                    .foregroundColor(.white)
                                    .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                            }
                        }
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                    }
                    .sheet(isPresented: $userViewModel.showFavouriteProductsView, content: {
                        FavouriteProductsView(viewModel: fruitViewModel)
                    })
                }
            }
            NavigationLink {
                ServiceInfoView()
            } label: {
                ZStack {
                    Color.theme.gray
                        .frame(height: 50)
                        .opacity(0.2)
                    HStack {
                        Text("О сервисе")
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                            .padding(.leading, 15)
                        Spacer()

                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                    }
//                    .sheet(isPresented: $showServiceInfoView, content: {
//                        ServiceInfoView()
//                    })
                }
            }
            ZStack {
                Button {
                    let formattedString = "tel://" + userViewModel.numberPhone
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)
                } label: {
                    ZStack {
                        Color.theme.gray
                            .frame(height: 50)
                            .opacity(0.2)
                        HStack {
                            Text("Служба поддержки")
                                .foregroundColor(.black)
                                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                                .padding(.leading, 15)
                            Spacer()
                            Image(systemName: "arrow.right")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.black)
                                .padding(.trailing, 20)
                        }
                    }
                }
            }
            Spacer()
            HStack {
                Button {
                    userViewModel.alert = true

                } label: {
                    HStack(spacing: 5) {
                        Image("out")
                            .foregroundColor(Color.white)
                        Text("Выход")
                            .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                            .foregroundColor(Color.black)
                    }
                }
                .alert(isPresented: $userViewModel.alert) {
                    Alert(title: Text("Sign Out"),
                          message: Text("Are you sure you want to log out of your account?"),
                          primaryButton: .destructive(Text("Yes")) {
                              UserDefaults.standard.set(false, forKey: "status")
                              NotificationCenter.default.post(name: NSNotification.Name("statusChange"),
                                                              object: nil)
                          },
                          secondaryButton: .cancel())
                }
                .padding(.vertical, 10)
                .padding(.horizontal)
                .padding(.leading, 10)
                Spacer()
            }
            .offset(y: -70)
            .navigationBarHidden(true)
        }
        .offset(y: -40)
        .ignoresSafeArea()
        .onAppear {
            for item in userViewModel.user {
                if userViewModel.email as! String == item.userEmail {
                    userViewModel.userName = item.userName
                    userViewModel.userSurname = item.userSurname
                }
            }

            orderViewModel.order.forEach { i in
                if i.email == userViewModel.email as! String {
                    userViewModel.countOrder += 1
                }
            }
        }
    }
}

// struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView(viewModel: FruitViewModel())
//    }
// }
