import SwiftUI

struct ProfileView: View {
    
    @StateObject var viewModel: FruitViewModel
    @StateObject var viewModels: OrderViewModel
    @State var showUserInfoView = false
    @State var showServiceInfoView = false
    @State var showShopView = false
    @State var showFavouriteProductsView = false

    var numberPhone = "+375297023701"
    @StateObject var user = FruitViewModel()
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    
    var body: some View {
        VStack {
            ZStack {
                Color.theme.lightGreen
                    .frame(height: 240)
                    .offset(y: -50)
                HStack {
//                    Button {
//                        user.showImagePicker = true
//                        sourceType = .photoLibrary
//                    } label: {
//                        ZStack {
//
//                            Image(uiImage: (user.userPhotoIntoAvatar ?? UIImage(systemName: "person.circle.fill")!))
//                                .resizable()
//                                .frame(width: 80, height: 80)
//                                .foregroundColor(.red)
//                                .cornerRadius(40)
//                                .padding(.leading, 15)
////                            Color.gray
////                                .frame(width: 80, height: 80)
////                                .opacity(0.5)
////                                .padding(.leading, 15)
//                        }
//                    }
//                    .fullScreenCover(isPresented: $user.showImagePicker) {
//                        ImagePicker(image: $user.userPhotoIntoAvatar, isShow: $user.showImagePicker, sourceType: sourceType)
//                    }
                    VStack {
                        Text(viewModels.user.userName.isEmpty || viewModels.user.userSurname.isEmpty ? "Имя Фамилия" : "\(viewModels.user.userName) \(viewModels.user.userSurname)")
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
                            viewModels: OrderViewModel(),
                            userName: viewModels.user.userName,
                            userSurname: viewModels.user.userSurname,
                            userPhone: viewModels.user.userPhone,
                            userEmail: viewModels.user.userEmail
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
                            Text("\(viewModels.orders.count)")
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
                        .opacity(0.4)
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
                        ShopsView()
                    })
                }
            }
            Button {
                self.showFavouriteProductsView.toggle()
            } label: {
                ZStack {
                    Color.theme.gray
                        .frame(height: 50)
                        .opacity(0.4)
                    HStack {
                        Text("Избранные товары")
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
                    .sheet(isPresented: $showFavouriteProductsView, content: {
                        FavouriteProductsView()
                    })
                }
            }
            Button {
                self.showServiceInfoView.toggle()
            } label: {
                ZStack {
                    Color.theme.gray
                        .frame(height: 50)
                        .opacity(0.4)
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
                    .sheet(isPresented: $showServiceInfoView, content: {
                        ServiceInfoView()
                    })
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
                            .opacity(0.4)
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
        ProfileView(viewModel: FruitViewModel(), viewModels: OrderViewModel())
    }
}
