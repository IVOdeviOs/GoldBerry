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
            ScrollView {
        ForEach(0 ..< viewModel.order.fruit.count) { row in
            VStack {
            HStack {
                Image(viewModel.order.fruit[row].image)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .padding(.leading, 10)
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(viewModel.order.fruit[row].cost) р/кг")
                        .foregroundColor(Color.theme.lightGreen)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                Text(viewModel.order.fruit[row].name)
                    .foregroundColor(.black)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                    Text(viewModel.order.fruit[row].description)
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(14, .uzSansRegular)))
                }
                Spacer()
            }
                Button {
                    viewModel.order.fruit.remove(at: row)
                } label: {
                    Text("Удалить")
                        .foregroundColor(Color.theme.gray)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                }
                HStack {
                    Button {
                        viewModel.order.fruit[row].count -= 1
                    } label: {
                        Image(systemName: "minus.square.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.theme.gray)
                    }
                    Text("\(viewModel.order.fruit[row].count) кг")
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(24, .uzSansRegular)))
                    Button {
                        viewModel.order.fruit[row].count += 1
                    } label: {
                        Image(systemName: "plus.square.fill")
                            .resizable()
                            .frame(width: 40, height: 40)
                            .foregroundColor(Color.theme.lightGreen)
                    }
                }
            }
        }
                .padding(.top, 80)
            }
            NavigationView {
                Button {
                    MakingTheOrderView()
                } label: {
                    Text("Оформить заказ")
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.theme.lightGreen)
                        .cornerRadius(10)
                }
            }
            Spacer()
        }
        .padding(.top, 0)
        .navigationBarHidden(true)
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: TabBarViewModel(), viewModels: OrderViewModel())
    }
}
