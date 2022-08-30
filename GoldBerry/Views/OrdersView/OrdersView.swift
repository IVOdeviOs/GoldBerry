import SwiftUI

struct OrdersView: View {

    @StateObject var viewModel: FruitViewModel
    @StateObject var viewModels: OrderViewModel

    var body: some View {
        if viewModels.orders.isEmpty {
            WithoutOrders(viewModel: viewModel)
        } else {
            WithOrders()
        }
    }
}

struct WithoutOrders: View {
    @StateObject var viewModel: FruitViewModel

    var body: some View {
        VStack {
            Image("noOrders")
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(20)
                .padding()
                .padding(.top, 90)
            Text("У вас пока нет заказов")
                .font(Font(uiFont: .fontLibrary(24, .uzSansRegular)))
            Text("Закажите что-нибудь свеженькое в нашем магазине")
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

struct WithOrders: View {
    @ObservedObject var viewModel = OrderViewModel()

    @State var show = false

    var body: some View {
        NavigationView {
            List(viewModel.orders) { item in
                Button(action: {
                    show.toggle()

                    print("\(item.date)")
                }, label: {
                    OrderCell(
                        date: item.date,
                        number: item.orderNumber,
                        price: item.price,
                        purchases: item.fruit,
                        address: item.address
                    )
                })
                .sheet(isPresented: $show, content: {

                    OrderInfoView(order: item)

                })

//                .padding()
            }
            .offset( y: -60)
            .navigationViewStyle(.columns)
            .listStyle(.plain)
        }
        .padding(.top, 0)
        .navigationBarHidden(true)
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView(viewModel: FruitViewModel(), viewModels: OrderViewModel())
    }
}
