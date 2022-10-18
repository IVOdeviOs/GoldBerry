import SwiftUI

struct OrdersView: View {

    @ObservedObject var orderViewModel: OrderViewModel
    @ObservedObject var fruitViewModel: FruitViewModel
    let email = UserDefaults.standard.value(forKey: "userEmail")

   

    var body: some View {

        if orderViewModel.orders() {
            WithoutOrders(orderViewModel: orderViewModel, fruitViewModel: fruitViewModel)
        } else {
            WithOrders(orderViewModel: orderViewModel)
        }
    }
}

struct WithoutOrders: View {

    @ObservedObject var orderViewModel: OrderViewModel
    @ObservedObject var fruitViewModel: FruitViewModel

    var body: some View {
        Color.theme.background
            .ignoresSafeArea()
            .overlay(
        VStack {
            Image("noOrders")
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(20)
                .padding()
                .padding(.top, 60)
            Text("У вас пока нет заказов")
                .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.bottom, 10)
            Text("Закажите что-нибудь свеженькое в нашем магазине")
                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.gray)
                .padding(.horizontal, 10)
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
            .background(Color.theme.background)
            )
    }
}

struct WithOrders: View {
    @ObservedObject var orderViewModel: OrderViewModel

    @State var show = false
    let email = UserDefaults.standard.value(forKey: "userEmail")

    var body: some View {
//        NavigationView {
            List(orderViewModel.order) { item in
                if item.email == email as! String {
                    NavigationLink {
                        OrderInfoView(order: item)
                    } label: {
                        OrderCell(
                            date: item.date,
                            dateOrder: item.dateOrder,
                            number: item.orderNumber,
                            price: Double(item.price),
                            purchases: item.fruit,
                            address: item.address,
                            orderCompleted: item.orderCompleted
                        )
                    }
                }
            }
            .padding(.bottom, 100)
            .accessibilityElement()
            .offset(y: 20)
            .navigationViewStyle(.columns)
            .listStyle(.plain)
//        }
        .padding(.top, 0)
        .navigationBarHidden(true)
    }
}

// struct OrdersView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrdersView(viewModel: FruitViewModel())
//    }
// }
