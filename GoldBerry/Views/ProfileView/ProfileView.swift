import SwiftUI

struct ProfileView: View {

    @StateObject var viewModel: FruitViewModel
    @StateObject var viewModels: OrderViewModel
    @State var show = false
    @State var show1 = false
    var numberPhone = "+375298308218"

    var body: some View {
        VStack {
            ZStack {
                Color.theme.lightGreen
                    .frame(height: 240)
                    .offset(y: -50)
                HStack {
                    ZStack {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(.white)
                            .padding(.leading, 15)
                        Color.gray
                            .frame(width: 80, height: 80)
                            .opacity(0.5)
                            .cornerRadius(40)
                            .padding(.leading, 15)
                    }
                    VStack {
                        Text("Имя Фамилия")
                            .foregroundColor(.white)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                        Text("Мои данные")
                            .foregroundColor(.white)
                            .font(Font(uiFont: .fontLibrary(16, .uzSansSemiBold)))
                    }
                    Spacer()
                    Button {
                        self.show.toggle()
                    } label: {
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(.white)
                            .padding(.trailing, 20)
                    }
                    .sheet(isPresented: $show, content: {
                        UserInfoView(viewModels: OrderViewModel())
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
                .offset(x: -130, y: -70)
            }
            Button {
                self.show.toggle()
            } label: {
                ZStack {
                    Color.theme.gray
                        .frame(height: 50)
                        .opacity(0.4)
                    HStack {
                        Text("Адреса торговых точек")
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                    }
                    .sheet(isPresented: $show, content: {
                        ShopsView()
                    })
                }
            }
            .padding(.bottom, 20)
            Button {
                self.show.toggle()
            } label: {
                ZStack {
                    Color.theme.gray
                        .frame(height: 50)
                        .opacity(0.4)
                    HStack {
                        Text("Избранные товары")
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                    }
                    .sheet(isPresented: $show, content: {
                        FavouriteProductsView()
                    })
                }
            }
            .padding(.bottom, 15)
            Button {
                self.show1.toggle()
            } label: {
                ZStack {
                    Color.theme.gray
                        .frame(height: 50)
                        .opacity(0.4)
                    HStack {
                        Text("О сервисе")
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                            .padding(.leading, 15)
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                    }

                    .alert("sda", isPresented: $show1, actions: {

//                    ServiceInfoView()
                        Button {
                            let formattedString = "tel://" + numberPhone
                            guard let url = URL(string: formattedString) else { return }
                            UIApplication.shared.open(url)
                        } label: {
                            HStack {
                                Image(systemName: "phone")
                                Text(numberPhone)
                            }
                            .frame(width: 350, height: 50)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                        }

                    })
 //                    .sheet(isPresented: $show1, content: {
//                        ServiceInfoView()
//                    })
                }
            }
            .padding(.bottom, 15)
            Button {
                self.show.toggle()
            } label: {
                ZStack {
                    Color.theme.gray
                        .frame(height: 50)
                        .opacity(0.4)
                    HStack {
                        Text("Служба поддержки")
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                            .padding(.leading, 15)
                        Spacer()

                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.black)
                            .padding(.trailing, 20)
                    }
                    .sheet(isPresented: $show, content: {
                        ServiceInfoView()
                    })
                }
            }
            .padding(.bottom, 15)
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
