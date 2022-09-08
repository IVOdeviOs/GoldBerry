import SwiftUI

struct CartView: View {
    @StateObject var viewModel = FruitViewModel()
    
    var body: some View {
        if viewModel.fruit.isEmpty {
            WithoutPurchase(viewModel: viewModel)
        } else {
            WithPurchase()
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
                .font(Font(uiFont: .fontLibrary(24, .uzSansRegular)))
            Text("Ваша корзина ждет, пока ее наполнят!")
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.gray)
            Button {
                viewModel.selected = 0
            } label: {
                Text("Перейти к выбору товаров")
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                    .background(Color.theme.lightGreen)
                    .cornerRadius(10)
            }
            Spacer()
                .navigationBarHidden(true)
        }
    }
}

struct WithPurchase: View {
    @ObservedObject var viewModel = FruitViewModel()

    @State var show = false
    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                ScrollView(showsIndicators: false) {
                    ForEach(viewModel.fruit) { item in
                        //                List(viewModel.order.fruit) { item in
                        Button {} label: {
                            CartCell(
                                imageName: item.image,
                                cost: Double(item.cost),
                                name: item.name,
                                index: item.name,
                                description: item.image ,
                                count: item.count,
                                price: Double(item.cost)
                            )
                        }
                        .padding()
                    }
//                    .onDelete(perform: delete)
                    .padding(.top, 125)
                    .padding(.bottom,100)
                }
                
            }
            .ignoresSafeArea()
            ZStack {
                VStack {
                    Spacer()
                    Button {
//                    MakingTheOrderView(viewModels: OrderViewModel())
                        self.show.toggle()
                    } label: {
                        Text("Оформить заказ   \(NSString(format: "%.2f", viewModel.price)) р")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                            .background(Color.theme.lightGreen)
                            .cornerRadius(10)
                            .padding(.bottom, 150)
                    }
                    .offset(y: 115)
                    .sheet(isPresented: $show, content: {
                        MakingTheOrderView(viewModel: viewModel)
                    })
//                        .background(.white)
//                        .navigationViewStyle(.columns)
//                        .listStyle(.plain)
//                        .background(.red)
                }
            }

            .navigationBarHidden(true)
        }
        .offset( y: -95)
//        .ignoresSafeArea(edges: .top)
    }

//    func delete(at offsets: IndexSet) {
//        viewModel.order.fruit.remove(atOffsets: offsets)
//    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: FruitViewModel())
    }
}
