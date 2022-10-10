import CoreData
import SwiftUI

struct CartView: View {
    @ObservedObject var viewModel = FruitViewModel()
//    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>

    var body: some View {
        if self.fruits.isEmpty {
            WithoutPurchase(viewModel: viewModel)
        } else {
            WithPurchase(viewModel: viewModel)
        }
    }
}

struct WithoutPurchase: View {
    @StateObject var viewModel: FruitViewModel

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
                viewModel.selected = 0
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
    @ObservedObject var viewModel: FruitViewModel
    @State var show = false
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.id, ascending: true)])

    var fruits: FetchedResults<FruitEntity>

//    @FetchRequest(entity: FruitOrderEntity.entity(), sortDescriptors: [])
//
//    var fruitOrder: FetchedResults<FruitOrderEntity>
//    @State var fruitOrder = [Fruit]()
    @State var suma: Double = 0
    @State var fruitO = [Fruit]()

    var body: some View {
        ZStack(alignment: .top) {

            ScrollView(showsIndicators: false) {
                ForEach(viewModel.uniqFruits) { item in
                    CartCell(
                        viewModel: viewModel,
                        fruit: item
                    )
                    .onTapGesture {
                        print("\(item.count)")
                    }
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
                        MakingTheOrderView(viewModel: viewModel)

                    } label: {
                        Text("Оформить заказ   \(NSString(format: "%.2f", viewModel.price!)) р")
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
        }

        .offset(y: -95)
        .onAppear {
            for item in viewModel.fruit {
                for i in fruits {
                    if i.id == item.id {
                        fruitO.append(item)
                        viewModel.uniqFruits = uniq(source: fruitO)
                        print("😶‍🌫️\(fruitO.count)")
                    }
                }
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: FruitViewModel())
    }
}

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
