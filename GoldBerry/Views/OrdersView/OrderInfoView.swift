
import SwiftUI

struct OrderInfoView: View {

    var order: Order
    @Environment(\.presentationMode) var presentation

//    @ObservedObject var order:OrderViewModel
    var body: some View {

        VStack {
            VStack {
                Text("Заказ № \( order.orderNumber)")
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
                    Text("\(order.dateOrder)")
                        .foregroundColor(Color.theme.gray)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        .padding()
                }
                ForEach(0 ..< order.fruit.count) { row in
                    HStack {
                        RemoteImageView(
                            url: URL(string: order.fruit[row].image)!,
                            placeholder: {
                                Image(systemName: "icloud.and.arrow.up").frame(width: 300, height: 300)
                            },
                            image: {
                                $0
                                    .resizable()
                                    .frame(width: 180, height: 120)
                                    .aspectRatio(contentMode: .fit)
                            }
                        )
                            .frame(width: 30, height: 30)
                            .cornerRadius(10)
                            .padding(.leading, 10)
                        Text(order.fruit[row].name)
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        Spacer()
                        Text("\(order.fruit[row].count)")
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        Text("\(NSString(format: "%.2f", order.fruit[row].itog)) p.")
                            .foregroundColor(Color.theme.lightGreen)
                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                            .frame(width: 80, height: 20)
                            .padding(.trailing, 10)
                    }
                }
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
         
           
            
        }
        .offset(y: 5)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Image(systemName: "arrow.backward")
                .resizable()
                .frame(width: 22, height: 20)
                .foregroundColor(.black)
                .onTapGesture {
                    self.presentation.wrappedValue.dismiss()
                }
        )
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
            order: Order(orderNumber: "1", date: "",dateOrder: "", email: "",fruit: [ Fruit( cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1, descriptions: "", price: 1)] ,address: "", price: 1, customer: "", customerPhone: "", comment: "", orderCompleted: false)
        )
    }
}

