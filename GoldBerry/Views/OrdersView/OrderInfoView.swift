
import SwiftUI

struct OrderInfoView: View {

    var order: Order

    var body: some View {

        VStack {
            VStack {
                Text("Заказ № \(order.orderNumber)")
                    .font(Font(uiFont: .fontLibrary(24, .uzSansBold)))
                    .foregroundColor(.black)
                    .padding()
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
                HStack {
                    Text("\(NSString(format: "%.2f", order.price)) p.")
                        .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                        .foregroundColor(.white)
                        .frame(width: 130, height: 30)
                        .background(.orange)
                        .cornerRadius(15)
                        .padding()
                    Spacer()
                    Text("\(order.date)")
                        .foregroundColor(Color.theme.gray)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        .padding()
                }
//                ForEach(0 ..< order.fruit.count) { row in
//                    HStack {
//                        Image(order.fruit[row].image)
//                            .resizable()
//                            .frame(width: 30, height: 30)
//                            .cornerRadius(10)
//                            .padding(.leading, 10)
//                        Text(order.fruit[row].name)
//                            .foregroundColor(.black)
//                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
//                        Spacer()
//                        Text("\(order.fruit[row].count)")
//                            .foregroundColor(.black)
//                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
//                        Text("\(NSString(format: "%.2f", order.fruit[row].cost)) p.")
//                            .foregroundColor(Color.theme.lightGreen)
//                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
//                            .frame(width: 80, height: 20)
//                            .padding(.trailing, 10)
//                    }
//                }
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
                HStack {
                    Image(systemName: "suitcase.cart")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Text("Доставка")
                        .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Spacer()
                }
                HStack {
                    Text("\(order.date)")
                        .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                        .foregroundColor(.black)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Spacer()
                }
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
                CustomerInfo(order: order)
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

struct CustomerInfo: View {

    var order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "face.smiling")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                Text("Получатель")
                    .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                    .foregroundColor(.black)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                Spacer()
            }
            Text("\(order.customer)")
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .foregroundColor(.black)
                .padding(.leading, 10)
            Text("\(order.customerPhone)")
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .foregroundColor(.black)
                .padding(.leading, 10)
            Text("\(order.address)")
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .foregroundColor(.black)
                .padding(.leading, 10)
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
            Spacer()
        }
    }
}

struct OrderInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OrderInfoView(
            order: Order(orderNumber: 1, date: "",fruit: [Fruits(cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1)] ,address: "", price: 1, customer: "", customerPhone: "", comment: "")
        )
    }
}

