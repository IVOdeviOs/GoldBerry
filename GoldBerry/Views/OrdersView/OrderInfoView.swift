
import SwiftUI

struct OrderInfoView: View {

    var order: Order
    @Environment(\.presentationMode) var presentation
    var body: some View {

        VStack {
            VStack {
                Text("Заказ № \(order.orderNumber)")
                    .font(Font(uiFont: .fontLibrary(24, .uzSansBold)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .padding()
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
                HStack {
                    Text("\(NSString(format: "%.2f", order.price)) p.")
                        .font(Font(uiFont: .fontLibrary(16, .uzSansBold)))
                        .foregroundColor(.white)
                        .frame(width: 130, height: 30)
                        .background(.orange)
                        .cornerRadius(8)
                        .padding()
                    Spacer()
                    Text("\(order.dateOrder)")
                        .foregroundColor(Color.theme.gray)
                        .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                        .padding()
                }
                HStack {
                     Spacer()
                     Text("Наименование")
                         .foregroundColor(Color.theme.blackWhiteText)
                         .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                         .frame(width: UIScreen.main.bounds.width/3, height: 20)
                     Text("Цена/ед.")
                         .foregroundColor(Color.theme.blackWhiteText)
                         .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                         .frame(width: UIScreen.main.bounds.width/6, height: 20)
                     Text("Кол-во")
                         .foregroundColor(Color.theme.blackWhiteText)
                         .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                         .frame(width: UIScreen.main.bounds.width/6, height: 20)
                     Text("Итого")
                         .foregroundColor(Color.theme.blackWhiteText)
                         .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                         .frame(width: UIScreen.main.bounds.width/6, height: 20)
                         .padding(.trailing, 20)
                 }
                 ForEach(0 ..< order.fruits.count) { row in
                     HStack {
                         RemoteImageView(
                             url: URL(string: order.fruits[row].image)!,
                             placeholder: {
                                 Image(systemName: "icloud.and.arrow.up").frame(width: 30, height: 30)
                             },
                             image: {
                                 $0
                                     .resizable()
                                     .frame(width: 30, height: 30)
                                     .aspectRatio(contentMode: .fill)
                             }
                         )
                         .frame(width: 30, height: 30)
                         .cornerRadius(10)
                         .padding(.leading, 10)
                         Text(order.fruits[row].name)
                             .minimumScaleFactor(0.7)
                             .foregroundColor(Color.theme.blackWhiteText)
                             .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                             .frame(width: UIScreen.main.bounds.width/4, height: 20)
                         Text("\(NSString(format: "%.2f", order.fruits[row].itog)) p.")
                             .foregroundColor(Color.theme.blackWhiteText)
                             .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                             .frame(width: UIScreen.main.bounds.width/6, height: 20)
                         Text("\(Int(order.fruits[row].count))")
                             .foregroundColor(Color.theme.blackWhiteText)
                             .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                             .frame(width: UIScreen.main.bounds.width/6, height: 20)
                         Text("\(NSString(format: "%.2f", order.fruits[row].itog * order.fruits[row].count)) p.")
                             .foregroundColor(Color.theme.blackWhiteText)
                             .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                             .frame(width: UIScreen.main.bounds.width/6, height: 20)
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
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Text("Доставка")
                        .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Spacer()
                }
                HStack {
                    Text("\(order.date)")
                        .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Spacer()
                }
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
                CustomerInfo(order: order)
//                Spacer()
            }
        }
        .offset(y: 35)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Image(systemName: "arrow.backward")
                .resizable()
                .foregroundColor(Color.theme.blackWhiteText)
                .frame(width: 22, height: 20)
                .padding(.top, 18)
                .foregroundColor(.black)
                .onTapGesture {
                    self.presentation.wrappedValue.dismiss()
                }
        )
        .gesture(DragGesture(minimumDistance: 50.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                switch(value.translation.width) {
                    case (0...500):   self.presentation.wrappedValue.dismiss()
                    default:  break
                }
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
                    .foregroundColor(Color.theme.blackWhiteText)
                    .frame(width: 25, height: 25)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                Text("Получатель")
                    .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                Spacer()
            }
            Text("\(order.customer)")
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.leading, 10)
            Text("\(order.customerPhone)")
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.leading, 10)
            Text("\(order.address)")
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.leading, 10)
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
            Spacer()
        }
    }
}
