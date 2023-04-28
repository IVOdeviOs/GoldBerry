import CoreData
import SwiftUI

struct CartView: View {

    @ObservedObject var fruitViewModel = FruitViewModel()
    @ObservedObject var orderViewModel = OrderViewModel()

    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>

    var body: some View {
        if self.fruits.isEmpty {
            WithoutPurchase(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
        } else {
            WithPurchase(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
        }
    }
}

struct WithoutPurchase: View {
    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var orderViewModel: OrderViewModel

    var body: some View {
        Color.theme.background
            .ignoresSafeArea()
            .overlay(
                VStack {
                    Image("noOrders")
                        .resizable()
                        .frame(width: UIScreen.main.bounds.width / 2, height: 300)
                        .cornerRadius(20)
                        .padding()
                        .padding(.top, 60)
                    Text("Your cart is empty")
                        .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProRegular)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.bottom, 10)
                    Text("Your cart is waiting to be filled!")
                        .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.grafit)
                    Button {
                        fruitViewModel.selected = 0
                    } label: {
                        Text("Go to product selection")
                            .frame(width: 300, height: 50)
                            .foregroundColor(.white)
                            .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                            .background(Color.theme.green4)
                            .cornerRadius(10)
                    }
                    Spacer()
                        .navigationBarHidden(true)
                }
                .background(Color.theme.background)
            )
    }
}

struct WithPurchase: View {
    @ObservedObject var fruitViewModel = FruitViewModel()
    @ObservedObject var orderViewModel: OrderViewModel

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>
    @State var fruitO = [Fruit]()
    @State var cartPrice: Double = 0
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    var body: some View {

        ZStack(alignment: .top) {

            ScrollView(showsIndicators: false) {
                ForEach(fruitViewModel.uniqFruits, id: \.id) { item in
                    CartCell(fruitViewModel: fruitViewModel,
                             orderViewModel: orderViewModel,
                             fruit: item)
                }
                .padding(.top, 125)
                .padding(.bottom, 100)
            }
            .padding(.vertical, 3)
            .padding(.horizontal, 10)

            .ignoresSafeArea()

            ZStack {
                VStack {
                    Spacer()

                    NavigationLink {
                        if status {
                            MakingTheOrderView(orderViewModel: orderViewModel, fruitViewModel: fruitViewModel)
                        } else {
                            LoginView(signUP: LogIn(), fruitViewModel: fruitViewModel)
                                .navigationBarBackButtonHidden(true)
                        }
                    } label: {
                        HStack {
                            Spacer()
                            Text("Make an order for  ")
                            Text("\(NSString(format: "%.2f", fruitViewModel.sum()))")
                            Text("$ ")
                            Spacer()
                        }
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                            .background(Color.theme.green4)
                            .cornerRadius(10)
                            .padding(.bottom, 150)
                    }
                    .offset(y: 115)
                }
            }
            .navigationBarHidden(true)
        }
        .offset(y: -95)
        .onAppear {
            fruitViewModel.arrayOfFruitPrice.removeAll()
            for item in fruitViewModel.fruit {
                for itemsFruits in fruits {
                    if itemsFruits.id == item.id {
                        fruitO.append(item)
                        fruitViewModel.uniqFruits = uniq(source: fruitO)
                    }
                }
            }

            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"),
                                                   object: nil,
                                                   queue: .main)
            { _ in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
        .onDisappear {
            fruitO.removeAll()
            for (index, value) in fruitViewModel.uniqFruits.enumerated() {
                if value.favorite {
                    fruitViewModel.uniqFruits.remove(at: index)
                }
               
            }
            orderViewModel.price = fruitViewModel.sum()
        }
    }
}

private func uniq<S: Sequence, T: Hashable>(source: S) -> [T] where S.Iterator.Element == T {
    var buffer = [T]()
    var added = Set<T>()
    for elem in source {
        if !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
    }
    return buffer
}
