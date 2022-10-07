import CoreData
import SwiftUI
extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphismtextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}

struct ContentView: View {
    @StateObject var viewModel = FruitViewModel()

    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    var body: some View {

        NavigationView {
            if status {
                ViewProfile(viewModel: viewModel)
            } else {
                LoginView(signUP: LogIn())
            }
        }.onAppear {
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
    @StateObject var viewModel = FruitViewModel()
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)],
        animation: .default
    )
    var fruits: FetchedResults<FruitEntity>
    var body: some View {
        ZStack {
            ExtractedView(viewModel: viewModel)
            ZStack {
                VStack {
                    ZStack {
                        HStack {

                            Text("GoldBerry")
                                .font(Font(uiFont: .fontLibrary(32, .uzSansBold)))
                                .foregroundColor(viewModel.selected == 3 ? .white : Color.theme.lightGreen)
                                .padding()
                            Spacer()
                            Image("goldBerryLogo")
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                                .padding()
                        }
//                                HStack(spacing: 5) {
//                                    Image(systemName: "cart.fill")
//                                        .resizable()
//                                        .frame(width: 25, height: 25)
//                                        .foregroundColor(Color.theme.lightGreen)
//
//                                    HStack(spacing: 1) {
//
//                                        Text("100000")
//                                            .font(Font(uiFont: .fontLibrary(16, .helvetica)))
//                                            .foregroundColor(.black)
//                                            .minimumScaleFactor(0.5)
//                                        Text("руб")
//                                            .font(Font(uiFont: .fontLibrary(16, .helvetica)))
//                                            .foregroundColor(.black)
//                                    }
//                                }
//                                .padding()
//                                .frame(width: 140, height: 45)
//                                .background(.white)
//                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
//                                .shadow(color: .green.opacity(0.2), radius: 10, x: 0, y: 10)
//                                .padding(.horizontal, 30)
//                            }
                        .padding(.top, 40)
                    }

                    Spacer()
                    ZStack(alignment: .bottom) {
                        HStack {
                            Button {
                                viewModel.selected = 0
                            } label: {
                                VStack {
                                    Image(systemName: "house")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Главная")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }
                            }.foregroundColor(viewModel.selected == 0 ? Color.theme.lightGreen : Color.theme.gray)
                            Spacer(minLength: 12)

                            Button {

                                viewModel.selected = 1
                            } label: {
                                ZStack {
                                    ZStack {
                                        if !fruits.isEmpty {
                                            Color.red
                                                .frame(width: 20, height: 20)
                                                .cornerRadius(10)
                                            Text("\(fruits.count)")
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
                                    }
                                }
                            }.foregroundColor(viewModel.selected == 1 ? Color.theme.lightGreen : Color.theme.gray)
                            Spacer()

                            Button {
                                viewModel.selected = 2
                            } label: {
                                VStack {
                                    Image(systemName: viewModel.selected == 2 ? "bag.fill" : "bag")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Заказы")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }
                            }.foregroundColor(viewModel.selected == 2 ? Color.theme.lightGreen : Color.theme.gray)
                            Spacer(minLength: 12)

                            Button {
                                viewModel.selected = 3
                            } label: {
                                VStack {
                                    Image(systemName: viewModel.selected == 3 ? "person.fill" : "person")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Профиль")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }
                            }.foregroundColor(viewModel.selected == 3 ? Color.theme.lightGreen : Color.theme.gray)
                        }
                        .padding()
                        .padding(.horizontal, 22)
                        //                        .background(Color.background)
                        .background(.white)
                    }

                    //                    .padding()
                    //                    .foregroundColor(Color.neumorphismtextColor)
                    //                    .background(Color.background)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    //                    .shadow(color: Color.lightShadow, radius: 5, x: -4, y: -4)
                    //                    .shadow(color: Color.darkShadow, radius: 5, x: 4, y: 4)
                    .padding(.bottom, 30)
                    .shadow(color: .green.opacity(0.5), radius: 20, x: 0, y: 10)
                }
            }
        }
        .ignoresSafeArea()
        .background(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ExtractedView: View {
    @ObservedObject var viewModel = FruitViewModel()

//    @ObservedObject var viewModels = OrderViewModel()
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])

    var fruits: FetchedResults<FruitEntity>
    var body: some View {
        ZStack {
            switch viewModel.selected {
            case 0:
                ProductsView(viewModel: viewModel)
                    .onAppear {
                        Task {
                            do {
                                try await viewModel.fetchFruit()
                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }
            case 1:
                CartView(viewModel: viewModel)
                    .onAppear {
//                        fruits.forEach { i in
//                            viewModel.fruit.forEach { item in
//
////                                viewModel.fruitOrder.forEach { f in
//                                    if  item.id == i.id {
//                                        
//                                        viewModel.fruitOrder = [item]
//                                        print("🥰\(viewModel.fruitOrder.count)")
////                                    }
//                                }
//
////                                    viewModel.fruitOrder.filter(item.id)
//                            }
//                        }
                        
                        Task {
                            do {
                                try await viewModel.fetchFruit()
                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }

            case 2:
                OrdersView(viewModel: viewModel)
                    .onAppear {
                        Task {
                            do {
                                try await viewModel.fetchOrder()
                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }
            case 3:
                ProfileView(viewModel: viewModel)
                    .onAppear {

                        Task {
                            do {
                                try await viewModel.fetchUser()
                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }

            default:
                ProductsView(viewModel: viewModel)
            }
        }
        //            .padding()
        .padding(.top, 90)
    }
}

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
