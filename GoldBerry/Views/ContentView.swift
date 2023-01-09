import CoreData
import SwiftUI

struct ContentView: View {
    @StateObject var fruitViewModel = FruitViewModel()
    @StateObject var orderViewModel = OrderViewModel()
    @StateObject var userViewModel = UserViewModel()
    @StateObject var adminViewModel = AdminViewModel()
    @State var tog = false
    @State var tog1 = false
//    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>
    func sendRequesting(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {

            completion(tog == false)
        }
    }

    var body: some View {

        NavigationView {
                if tog {
                    withAnimation {
                        LaunchScreenView()
                    }
                } else {
//                    ProductView()
//                    if adminViewModel.statusAdmin {
//                        ProductView()
//                    }else{
                        ViewProfile(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel, userViewModel: userViewModel,adminViewModel: adminViewModel)
                        .environment(\.locale, .init(identifier: adminViewModel.language ?? "ru"))
//                    }
                }
            
        }.onAppear {

            if !fruits.isEmpty {
                fruitViewModel.isShowCount = true
            }
            Task {
                do {
                    try await fruitViewModel.fetchFruit()
                } catch {
                }
            }
            tog = true
            sendRequesting { to in
                tog = to
            }
//
//            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"),
//                                                   object: nil,
//                                                   queue: .main)
//            { _ in
//                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
//                self.status = status
//            }
        }
    }
}

struct ViewProfile: View {
    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var orderViewModel: OrderViewModel
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var adminViewModel: AdminViewModel
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>

    var body: some View {
        ZStack {
            ExtractedView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel, userViewModel: userViewModel,adminViewModel: adminViewModel)
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
                                    Text("Home")
//                                    Text("Главная")
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
                                        Text("Cart")
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
                                    Text("Order")
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
                                    Text("Profile")
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
    }
}

struct ExtractedView: View {
    @ObservedObject var fruitViewModel = FruitViewModel()
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var adminViewModel: AdminViewModel
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
                    .onAppear {
                        Task {
                            do {
                                try await fruitViewModel.fetchFruit()
                            } catch {
                            }
                        }
                    }

            case 1:
                CartView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
                    .onAppear {
                        Task {
                            do {
                                try await fruitViewModel.fetchFruit()
                            } catch {
                            }
                        }
                    }
            case 2:
                OrdersView(orderViewModel: orderViewModel, fruitViewModel: fruitViewModel)
                    .onAppear {
                        Task {
                            do {
                                try await orderViewModel.fetchOrder()
                            } catch {
                            }
                        }
                    }
            case 3:
                ProfileView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel, userViewModel: userViewModel,adminViewModel: adminViewModel )
                    .onAppear {

                        Task {
                            do {
                                try await fruitViewModel.fetchFruit()

                            } catch {
                            }
                        }
                    }

            default:
                ProductsView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
            }
        }
        .padding(.top, 90)
        .onAppear {
            Task {
                do {
                    try await orderViewModel.fetchOrder()
                } catch {
                }
            }
        }
    }
}
