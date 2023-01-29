import SwiftUI

struct OrdersView: View {

    @ObservedObject var orderViewModel: OrderViewModel
    @ObservedObject var fruitViewModel: FruitViewModel
    let email = UserDefaults.standard.value(forKey: "userEmail")

    func orders() -> Bool {
        var ordersBool = true
        for item in orderViewModel.order {
            if item.email == email as? String {
                ordersBool = false
            }
        }
        return ordersBool
    }

    var body: some View {

        if orders() {
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
                        .frame(width: UIScreen.main.bounds.width / 1.1, height: 300)
                        .cornerRadius(20)
                        .padding()
                        .padding(.top, 60)
                    Text("You have no orders")
                        .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.bottom, 10)
                    Text("Order something fresh in our shop")
                        .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.gray)
                        .padding(.horizontal, 10)
                    Button {
                        fruitViewModel.selected = 0
                    } label: {
                        Text("Go to product selection")
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
        List(orderViewModel.order.sorted(by: { items1, items2 in
            items1.date.trimmingCharacters(in: CharacterSet(charactersIn: " ")) > items2.date.trimmingCharacters(in: CharacterSet(charactersIn: " "))
        })) { item in
            if item.email == email as? String {
                NavigationLink {
                    OrderInfoView(order: item)
                } label: {
                    OrderCell(
                        date: item.date,
                        dateOrder: item.dateOrder,
                        number: item.orderNumber,
                        price: item.prices,
                        purchases: item.fruits,
                        address: item.address,
                        orderCompleted: item.orderCompleted
                    )
                }
            }
        }

        .padding(.bottom, 140)
        .accessibilityElement()
        .offset(y: 20)
        .navigationViewStyle(.columns)
        .listStyle(.plain)
        .padding(.top, 0)
        .navigationBarHidden(true)
    }
}
