import SwiftUI

struct ProfileView: View {
    
    @FetchRequest(entity: UserRegEntity.entity(), sortDescriptors: [])
    var users: FetchedResults<UserRegEntity>
    
    
    @StateObject var viewModel: FruitViewModel
    //    @StateObject var viewModels: OrderViewModel
//    @State var showUserInfoView = false
    @State var showServiceInfoView = false
    @State var showShopView = false
    @State var showFavouriteProductsView = false

    var numberPhone = "+375336096300"
    @StateObject var user = FruitViewModel()
    @State var alert = false
    @State var countOrder = 0
    let email = UserDefaults.standard.value(forKey: "userEmail")
    
    var body: some View {
        VStack {
            ZStack {
                Color.theme.lightGreen
                    .frame(height: 240)
                    .offset(y: -50)
                HStack {
                    VStack {
                        Text(viewModel.userName.isEmpty && viewModel.userSurname.isEmpty ? "Имя Фамилия" : "\(viewModel.userName) \(viewModel.userSurname)")
                            .foregroundColor(.white)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                            .padding()
                    }
                                        Spacer()
                    Button {
                        self.viewModel.showUserInfoView.toggle()
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }
                    .sheet(isPresented: $viewModel.showUserInfoView, content: {
                        UserInfoView(
                            viewModel: viewModel
//                            userName: viewModel.users.userName,
//                            userSurname: viewModel.users.userSurname,
//                            userPhone: viewModel.users.userPhone
//                            userEmail: viewModel.user.userEmail
                        )
                    })
                }
            }
            ZStack {
                Button {
                    viewModel.selected = 2
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
                            Text("\(countOrder)")
                                .font(Font(uiFont: .fontLibrary(24, .uzSansSemiBold)))
                                .foregroundColor(.black)
                        }
                    }
                }
                .offset(x: -110, y: -80)
            }
            Button {
                self.showShopView.toggle()
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
                    .sheet(isPresented: $showShopView, content: {
                        ShopsView(viewModel: viewModel)
                    })
                }
            }
            Button {
                self.showFavouriteProductsView.toggle()
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
                            if viewModel.favouriteProducts.count != 0 {
                                Color.red
                                    .frame(width: 20, height: 20)
                                    .cornerRadius(10)
                                Text("\(viewModel.favouriteProducts.count)")
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
                    .sheet(isPresented: $showFavouriteProductsView, content: {
                        FavouriteProductsView(viewModel: viewModel)
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
                    let formattedString = "tel://" + numberPhone
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
                    alert = true

                } label: {
                    HStack(spacing: 5) {
                        Image("out")
                            .foregroundColor(Color.white)
                        Text("Выход")
                            .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                            .foregroundColor(Color.black)
                    }

                }
                .alert(isPresented: $alert) {
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
        .onAppear{
            for item in viewModel.user{
                if email as! String  == item.userEmail{
                    viewModel.userName = item.userName
                    viewModel.userSurname = item.userSurname
                }
            }
            
               
                viewModel.order.forEach { i in
                   if i.email == email as! String{
                         countOrder += 1
                   }
                }
                
                
         

            
        }
    }
   
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: FruitViewModel())
    }
}
