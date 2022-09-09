import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: FruitViewModel
    //    @StateObject var viewModels: OrderViewModel
    @State var showUserInfoView = false
    @State var showServiceInfoView = false
    @State var showShopView = false
    @State var showFavouriteProductsView = false
    
    var numberPhone = "+375336096300"
    @StateObject var user = FruitViewModel()
    
    var body: some View {
        VStack {
            ZStack {
                Color.theme.lightGreen
                    .frame(height: 240)
                    .offset(y: -50)
                HStack {
                    VStack {
                        Text(viewModel.user.userName.isEmpty || viewModel.user.userSurname.isEmpty ? "Имя Фамилия" : "\(viewModel.user.userName) \(viewModel.user.userSurname)")
                            .foregroundColor(.white)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                            .padding()
                    }
                    Spacer()
                    Button {
                        self.showUserInfoView.toggle()
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }
                    .sheet(isPresented: $showUserInfoView, content: {
                        UserInfoView(
                            viewModel: viewModel,
                            userName: viewModel.user.userName,
                            userSurname: viewModel.user.userSurname,
                            userPhone: viewModel.user.userPhone,
                            userEmail: viewModel.user.userEmail
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
                            Text("\(viewModel.order.count)")
                                .font(Font(uiFont: .fontLibrary(24, .uzSansSemiBold)))
                                .foregroundColor(.black)
                        }
                    }
                }
                .offset(x: -110, y: -70)
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
                    viewModel.selected = 0
                } label: {
                    Text("Выход")
                        .frame(width: 100, height: 50)
                        .foregroundColor(Color.theme.gray)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                }
                .padding(.leading, 10)
                Spacer()
            }
            .offset(y: -70)
            .navigationBarHidden(true)
        }
        .offset(y: -40)
        .ignoresSafeArea()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(viewModel: FruitViewModel())
    }
}
