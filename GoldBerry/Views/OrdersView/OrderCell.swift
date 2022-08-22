import SwiftUI

struct OrderCell: View {

    let date: String
    let number: Int
    let price: Double
    var purchases: [Fruit]
    let address: String

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(date)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        .foregroundColor(Color.theme.gray)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        .padding(.bottom, 1)
                    Text("Заказ № \(number)")
                        .font(Font(uiFont: .fontLibrary(18, .uzSansRegular)))
                        .padding(.leading, 10)
                }
                Spacer()
                Text("\(NSString(format: "%.2f", price)) p.")
                    .frame(width: 130, height: 30)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                    .minimumScaleFactor(0.5)
                    .foregroundColor(.white)
                    .background(.orange)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
            }
            Color.theme.gray
                .frame(height: 3)
            ForEach(0 ..< purchases.count) { row in
                HStack {
                    Image(purchases[row].imageName)
                        .resizable()
                        .frame(width: 30, height: 30)
                        .cornerRadius(10)
                        .padding(.leading, 10)
                    Text(purchases[row].name)
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    Spacer()
                    Text("\(purchases[row].count)")
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    Text("\(purchases[row].cost) p.")
                        .foregroundColor(Color.theme.lightGreen)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        .frame(width: 80, height: 20)
                        .padding(.trailing, 10)
                }
            }
            //            NavigationView {
            //                List(purchases) { item in
            //                    NavigationLink {
            //                    }
            //                label: {
            //                    PurchasesCell(
            //                        imageName: item.imageName,
            //                        name: item.name,
            //                        cost: item.cost,
            //                        count: item.count
            //                    )
            //                }
            //                }
            //                .listStyle(.plain)
            //            }
            VStack {
                Text("Доставка: \(address)")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                    .padding()
                Text("Дата доставки: \(date)")
                    .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                    .padding(.bottom, 10)
            }
        }
        .background(.gray.opacity(0.3))
        .overlay(
                   RoundedRectangle(cornerRadius: 20)
                    .stroke(Color.theme.gray, lineWidth: 2)
               )
        .cornerRadius(20)
    }
}

struct OrderCell_Previews: PreviewProvider {
    static var previews: some View {
        OrderCell(
            date: "18/08/2022",
            number: 1,
            price: 1000,
            purchases: [watermelon, apple, apricot, banana],
            address: "Минск, пр-т Независимости, 12-100"
        )
    }
}
