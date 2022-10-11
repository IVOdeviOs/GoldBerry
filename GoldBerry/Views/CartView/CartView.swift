import CoreData
import SwiftUI

struct CartView: View {
    
    
    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var orderViewModel: OrderViewModel
//    @Environment(\.managedObjectContext) private var viewContext
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
        VStack {
            Image("noOrders")
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(20)
                .padding()
                .padding(.top, 90)
            Text("В корзине пока пусто")
                .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                .foregroundColor(.black)
                .padding(.bottom, 10)
            Text("Ваша корзина ждет, пока ее наполнят!")
                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.gray)
            Button {
                fruitViewModel.selected = 0
            } label: {
                Text("Перейти к выбору товаров")
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .background(Color.theme.lightGreen)
                    .cornerRadius(10)
            }
            Spacer()
                .navigationBarHidden(true)
        }
    }
}

struct WithPurchase: View {
    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var orderViewModel: OrderViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>
    @State var fruitO = [Fruit]()
    @State var cartPrice: Double = 0

    
    var body: some View {
        ZStack(alignment: .top) {

            ScrollView(showsIndicators: false) {
                ForEach(fruitViewModel.uniqFruits) { item in
                  CartCell(fruitViewModel: fruitViewModel,
                           orderViewModel: orderViewModel,
                           fruit: item)
                }
                .padding(.vertical, 3)
                .padding(.horizontal, 10)
                .padding(.top, 125)
                .padding(.bottom, 100)
                .ignoresSafeArea()
            }
            ZStack {
                VStack {
                 
                    
                    Spacer()

                    NavigationLink {
                      
                        MakingTheOrderView(orderViewModel: orderViewModel, fruitViewModel: fruitViewModel)
//                        orderViewModel.show.toggle()
                    } label: {
                        Text("Оформить заказ \(NSString(format: "%.2f", fruitViewModel.sum())) р")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                            .background(Color.theme.lightGreen)
                            .cornerRadius(10)
                            .padding(.bottom, 150)
                    }
                    .offset(y: 115)
                }
            }
            .navigationBarHidden(true)
        }.sheet(isPresented: $orderViewModel.show, content: {
            MakingTheOrderView(orderViewModel: orderViewModel, fruitViewModel: fruitViewModel)
        })

        .offset(y: -95)
        .onAppear {
            print("cccc---------- \(fruitViewModel.arrayOfFruitPrice.count)")
            for item in fruitViewModel.fruit {
                for i in fruits {
                    if i.id == item.id {
                        fruitO.append(item)
                        fruitViewModel.uniqFruits = uniq(source: fruitO)
                        for asd in fruitViewModel.uniqFruits {
                            print("😶‍🌫️\(asd.count)")
                        }
                    }
                }
            }
        }
        .onDisappear {
            orderViewModel.price = fruitViewModel.sum()
        }
    }
}

// struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView(viewModel: FruitViewModel())
//    }
// }

private func uniq<S: Sequence, T: Hashable>(source: S) -> [T] where S.Iterator.Element == T {
    var buffer = [T]() // возвращаемый массив
    var added = Set<T>() // набор - уникальные значения
    for elem in source {
        if !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
    }
    return buffer
}
