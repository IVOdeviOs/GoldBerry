import SwiftUI

struct DeliveryInfoView: View {
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
        VStack {
            Text("Служба поддержки")
                .font(Font(uiFont: .fontLibrary(25, .uzSansBold)))
                .foregroundColor(.black)
                .padding()
            Text("Контактный телефон")
                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                .foregroundColor(.black)
            Text("+375-33-609-63-00")
                .font(Font(uiFont: .fontLibrary(40, .uzSansBold)))
                .foregroundColor(Color.theme.lightGreen)
                .padding(.bottom, 5)
            Text("Оплата и доставка")
                .font(Font(uiFont: .fontLibrary(25, .uzSansBold)))
                .foregroundColor(.black)
            Image(systemName: "rublesign.circle.fill")
                .resizable()
                .frame(width: 60, height: 60)
                .foregroundColor(Color.theme.lightGreen)
            Text("Оплата наличными")
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .foregroundColor(.black)
                .padding(.bottom, 5)
            Text("Можно оплатить товары курьеру при получении")
                .font(Font(uiFont: .fontLibrary(15, .uzSansLight)))
                .foregroundColor(.black)
                .minimumScaleFactor(0.5)
            HStack {
                Spacer()
                VStack {
                Image(systemName: "iphone")
                    .resizable()
                    .frame(width: 50, height: 80)
                    .foregroundColor(.red)
                    .padding(.trailing, -80)
            Text("Оформляете заказ\n        в приложении")
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .foregroundColor(.black)
                .minimumScaleFactor(0.5)
                .padding(.trailing, 60)
                }
            }
            HStack {
                VStack {
                Image(systemName: "phone.circle")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.red)
                    .padding(.leading, -80)
            Text("С Вами свяжется\nкурьер для уточнения\nвремени доставки")
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .foregroundColor(.black)
                .minimumScaleFactor(0.5)
                .padding(.leading, 60)
                }
                Spacer()
            }
            HStack {
                Spacer()
                VStack {
                Image(systemName: "creditcard")
                    .resizable()
                    .frame(width: 80, height: 50)
                    .foregroundColor(.red)
                    .padding(.trailing, -20)
            Text("Оплачиваете заказ\n       при получении")
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .foregroundColor(.black)
                .minimumScaleFactor(0.5)
                .padding(.trailing, 60)
                }
            }
        }
        }
    }
}

struct DeliveryInfoView_Previews: PreviewProvider {
    static var previews: some View {
        DeliveryInfoView()
    }
}
