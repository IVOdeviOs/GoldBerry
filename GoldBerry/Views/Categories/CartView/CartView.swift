import SwiftUI

struct CartView: View {
    @StateObject var viewModel: TabBarViewModel
    @StateObject var viewModels: OrderViewModel

    var body: some View {
        if viewModels.order.fruit.isEmpty {
            WithoutPurchase(viewModel: viewModel)
        } else {
            WithPurchase()
        }
    }
}

struct WithoutPurchase: View {
    @StateObject var viewModel: TabBarViewModel

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
    @ObservedObject var viewModel = OrderViewModel()

    @State var show = false

    var body: some View {
        VStack {
//            ScrollView {
//        ForEach(0 ..< viewModel.order.fruit.count) { row in
                List(viewModel.order.fruit) { item in
                    Button {

                    } label: {
                        CartCell(
                            imageName: item.image,
                            cost: item.cost,
                            name: item.name,
                            index: item.id,
                            description: item.description,
                            count: item.count,
                            price: item.cost
                        )
                    }
                    
                }
                .padding(.top, 80)
//            }
            NavigationLink {
                    MakingTheOrderView(viewModels: OrderViewModel())
                } label: {
                    Text("Оформить заказ   \(NSString(format: "%.2f", viewModel.order.price)) р")
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.theme.lightGreen)
                        .cornerRadius(10)
                        .padding(.bottom, 150)
                }
                .background(.white)
                .navigationViewStyle(.columns)
                .listStyle(.plain)
                .background(.red)
        }
        .navigationBarHidden(true)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: TabBarViewModel(), viewModels: OrderViewModel())
    }
}
