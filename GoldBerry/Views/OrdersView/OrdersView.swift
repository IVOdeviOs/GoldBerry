import SwiftUI

struct OrdersView: View {
    
    var orders: [Order] = [
        Order(
            orderNumber: 1,
            fruit: [watermelon, apple, apricot, banana],
            date: "18/08/2022",
            address: "Минск, пр-т Независимости, 10-23",
            price: 1000
        ),
        Order(
            orderNumber: 2,
            fruit: [banana],
            date: "19/08/2022",
            address: "Минск, пр-т Независимости, 10-23",
            price: 1000
        )
    ]
    
    var body: some View {
        if orders.isEmpty {
            WithoutOrders()
        } else {
            WithOrders()
        }
    }
}

struct WithoutOrders: View {
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
            NavigationLink {
                ContentView()
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
    var orders: [Order] = [
        Order(
            orderNumber: 1,
            fruit: [watermelon, apple, apricot, banana],
            date: "18/08/2022",
            address: "Минск, пр-т Независимости, 10-23",
            price: 1000
        ),
        Order(
            orderNumber: 2,
            fruit: [banana],
            date: "19/08/2022",
            address: "Минск, пр-т Независимости, 10-23",
            price: 1000
        )
    ]
    
    var body: some View {
        NavigationView {
            List(orders) { item in
                NavigationLink {
                    OrderInfoView(order: item)
                    List{}
                }
            label: {
                OrderCell(
                    date: item.date,
                    number: item.orderNumber,
                    price: item.price,
                    purchases: item.fruit,
                    address: item.address
                )
            }
            .background(.white)
            .cornerRadius(20)
            .border(Color.theme.gray, width: 2)

            }
            .listStyle(.plain)
            .offset(y: -100)
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}

