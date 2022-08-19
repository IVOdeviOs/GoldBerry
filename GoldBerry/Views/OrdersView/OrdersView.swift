import SwiftUI

struct OrdersView: View {

    @StateObject var viewModel: TabBarViewModel

    var body: some View {
        if viewModel.orders.isEmpty {
            WithoutOrders(viewModel: viewModel)
        } else {
            WithOrders()
        }
    }
}

struct WithoutOrders: View {
    @StateObject var viewModel: TabBarViewModel

    var body: some View {
        VStack {
            Image("noOrders")
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(20)
                .padding()
                .padding(.top, 90)
            Text("У вас пока нет заказов")
                .font(Font(uiFont: .fontLibrary(.size24, .uzSansRegular)))
            Text("Закажите что-нибудь свеженькое в нашем магазине")
                .font(Font(uiFont: .fontLibrary(.size16, .uzSansRegular)))
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.gray)
            Button {
                viewModel.selected = 0
            } label: {
                Text("Перейти к выбору товаров")
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .font(Font(uiFont: .fontLibrary(.size20, .uzSansRegular)))
                    .background(Color.theme.lightGreen)
                    .cornerRadius(10)
            }
            Spacer()
                .navigationBarHidden(true)
        }
    }
}

struct WithOrders: View {
    @ObservedObject var viewModel = TabBarViewModel()

    @State var show = false

    var body: some View {
//        NavigationView {
        ScrollView {
            ForEach(viewModel.orders) { item in

                Button {
                    show.toggle()
                } label: {
                    OrderCell(
                        date: item.date,
                        number: item.orderNumber,
                        price: item.price,
                        purchases: item.fruit,
                        address: item.address
                    ).padding(.vertical)
                        
                }.sheet(isPresented: $show) {
                    OrderInfoView(order: item)
                }
                .padding(.horizontal, 10)
            }

//            .listStyle(.plain)
//            .listSectionSeparator(.hidden)
        }
        .padding(.top, 30)
//        .offset(y: 100)
        .navigationBarHidden(true)
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView(viewModel: TabBarViewModel())
    }
}
