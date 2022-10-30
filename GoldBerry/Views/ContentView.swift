import CoreData
import SwiftUI

struct ContentView: View {
    @StateObject var fruitViewModel = FruitViewModel()
    @StateObject var orderViewModel = OrderViewModel()
    @StateObject var userViewModel = UserViewModel()

    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>
    var body: some View {

        NavigationView {
            if status {
                ViewProfile(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel, userViewModel: userViewModel)
            } else {
                LoginView(signUP: LogIn())
            }
        }.onAppear {
            if !fruits.isEmpty {
                fruitViewModel.isShowCount = true
            }

            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"),
                                                   object: nil,
                                                   queue: .main)
            { _ in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
    }
}

struct ViewProfile: View {
    @ObservedObject var fruitViewModel = FruitViewModel()
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>

    var body: some View {
        ZStack {
            ExtractedView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel, userViewModel: userViewModel)
            ZStack {
                VStack {
                    ZStack {
                        HStack {
                            Text("GoldBerry")
                                .font(Font(uiFont: .fontLibrary(32, .uzSansBold)))
                                .foregroundColor(fruitViewModel.selected == 3 ? Color.theme.background : Color.theme.lightGreen)
                                .padding()
                            Spacer()
                            Image("goldBerryLogo")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                                .padding()
                        }
                        .padding(.top, 40)
                    }
                    .background(.clear)
                    Spacer()
                    ZStack(alignment: .bottom) {
                        HStack {
                            Button {
                                fruitViewModel.selected = 0
                            } label: {
                                VStack {
                                    Image(systemName: "house")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Главная")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }
                            }.foregroundColor(fruitViewModel.selected == 0 ? Color.theme.lightGreen : Color.theme.gray)
                            Spacer(minLength: 12)

                            Button {
                                fruitViewModel.selected = 1
                            } label: {
                                ZStack {
                                    ZStack {
                                        if fruitViewModel.isShowCount, fruitViewModel.countCart != 0 {
                                            Color.red
                                                .frame(width: 20, height: 20)
                                                .cornerRadius(10)
                                            Text("\(fruitViewModel.countCart)")
                                                .minimumScaleFactor(0.5)
                                                .foregroundColor(.white)
                                                .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                        } else {}
                                    }
                                    .offset(x: 20, y: -20)

                                    VStack {
                                        Image(systemName: "cart")
                                            .resizable()
                                            .frame(width: 23, height: 20)
                                        Text("Корзина")
                                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                    }.badge(fruits.count)
                                }
                            }.foregroundColor(fruitViewModel.selected == 1 ? Color.theme.lightGreen : Color.theme.gray)
                            Spacer()

                            Button {
                                fruitViewModel.selected = 2
                            } label: {
                                VStack {
                                    Image(systemName: fruitViewModel.selected == 2 ? "bag.fill" : "bag")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Заказы")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }
                            }.foregroundColor(fruitViewModel.selected == 2 ? Color.theme.lightGreen : Color.theme.gray)
                            Spacer(minLength: 12)

                            Button {
                                fruitViewModel.selected = 3
                            } label: {
                                VStack {
                                    Image(systemName: fruitViewModel.selected == 3 ? "person.fill" : "person")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Профиль")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }
                            }.foregroundColor(fruitViewModel.selected == 3 ? Color.theme.lightGreen : Color.theme.gray)
                        }
                        .padding()
                        .padding(.horizontal, 22)
                        .background(Color.theme.tabBarBackground)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .padding(.bottom, 30)
                    .shadow(color: Color.theme.lightGreen.opacity(0.5), radius: 8, x: 0, y: 5)
                }
            }
        }
        .ignoresSafeArea()
        .background(.clear)
        .onAppear {
            if fruitViewModel.showCartCount == true {
                fruitViewModel.countCart = fruits.count
            }
        }
//        .isLoading(fruitViewModel.isLoading)
    }
}

struct ExtractedView: View {
    @ObservedObject var fruitViewModel = FruitViewModel()
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)],
        animation: .default
    )
    var fruits: FetchedResults<FruitEntity>

    var body: some View {
        ZStack {
            switch fruitViewModel.selected {
            case 0:
                ProductsView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
//                    .onAppear{
//                        fruitViewModel.fetchAllRestaurants()
//                    }
                    .onAppear {
                        Task {
                            do {
                                try await fruitViewModel.fetchFruit()
                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }

            case 1:
                CartView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
//                    .onAppear {
//                        Task {
//                            do {
//                                try await fruitViewModel.fetchFruit()
//                            } catch {
//                                print("❌ERORR \(error)")
//                            }
//                        }
//                    }

            case 2:
                OrdersView(orderViewModel: orderViewModel, fruitViewModel: fruitViewModel)
                    .onAppear {
                        Task {
                            do {
                                try await orderViewModel.fetchOrder()
                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }
            case 3:
                ProfileView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel, userViewModel: userViewModel)
                    .onAppear {

                        Task {
                            do {
//                                try await userViewModel.fetchUser()
                                try await fruitViewModel.fetchFruit()

                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }

            default:
                ProductsView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
            }
        }
        .gesture(DragGesture(minimumDistance: 150.0, coordinateSpace: .local)
            .onEnded { value in
                
                switch value.translation.width {
                case 0 ... 500: fruitViewModel.selected -= 1
                case -500 ... 0: fruitViewModel.selected += 1
                default: break
                   
                }
            }
        )
        .padding(.top, 90)
        .onAppear {
            Task {
                do {
                    try await orderViewModel.fetchOrder()
                    try await fruitViewModel.fetchFruit()
                } catch {
                    print("❌ERORR \(error)")
                }
            }
            
        }
    }
}
