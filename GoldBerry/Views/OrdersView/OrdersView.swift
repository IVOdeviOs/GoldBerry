import SwiftUI

struct OrdersView: View {

    @StateObject var viewModel: FruitViewModel

    var body: some View {
        if viewModel.order.isEmpty {
            WithoutOrders(viewModel: viewModel)
        } else {
            WithOrders(viewModel: viewModel)
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
                .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                .foregroundColor(.black)
                .padding(.bottom, 10)
            Text("Закажите что-нибудь свеженькое в нашем магазине")
                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.gray)
                .padding(.horizontal, 10)
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

struct WithOrders: View {
    @ObservedObject var viewModel: FruitViewModel

    @State var show = false
    let email = UserDefaults.standard.value(forKey: "userEmail")

    var body: some View {
        NavigationView {
            List(viewModel.order) { item in
                if item.email == email as! String{
                    NavigationLink {
                        OrderInfoView(order: item)
                    } label: {
                        OrderCell(
                            date: item.date,
                            number: item.orderNumber,
                            price: Double(item.price),
                            purchases: item.fruit,
                            address: item.address
                        )
                    }
                }
//                Button(action: {
//                    show.toggle()
//
//                    print("\(item.date)")
//                }, label: {
//                    OrderCell(
//                        date: item.date,
//                        number: item.orderNumber,
//                        price: Double(item.price),
//                        purchases: item.fruit,
//                        address: item.address
//                    )
//                })
//                .sheet(isPresented: $show, content: {
//
//                    OrderInfoView(order: item)
//
//                })
//
                ////                .padding()
            }

            .offset(y: 20)
            .navigationViewStyle(.columns)
            .listStyle(.plain)
        }
        .padding(.top, 0)
        .navigationBarHidden(true)
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView(viewModel: FruitViewModel())
    }
}
