import SwiftUI

struct OrderCell: View {
    
    let date: String
    let number: Int
    let price: Double
    let purchases: [Fruit]
    let address: String
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(date)
                        .font(Font(uiFont: .fontLibrary(.size12, .helvetica)))
                        .foregroundColor(Color.theme.gray)
                        .padding(.leading, 10)
                        .padding(.bottom, 1)
                    Text("Заказ № \(number)")
                        .font(Font(uiFont: .fontLibrary(.size18, .helvetica)))
                        .padding(.leading, 10)
                }
                Spacer()
                Text("\(NSString(format: "%.2f", price))")
                    .frame(width: 100, height: 30)
                    .font(Font(uiFont: .fontLibrary(.size20, .helvetica)))
                    .foregroundColor(.white)
                    .background(.orange)
                    .cornerRadius(10)
                    .padding(.trailing, 10)
            }
            Color.theme.gray
                .frame(height: 3)
            NavigationView {
                List(purchases) { item in
                    NavigationLink {
                    }
                label: {
                    PurchasesCell(
                        imageName: item.imageName,
                        name: item.name,
                        cost: item.cost,
                        count: item.count
                    )
                }
                }
                .listStyle(.plain)
            }
            VStack {
                Text("Доставка: \(address)")
                    .fixedSize(horizontal: false, vertical: true)
                    .font(Font(uiFont: .fontLibrary(.size16, .helvetica)))
                    .padding()
                Text("Дата доставки: \(date)")
                    .font(Font(uiFont: .fontLibrary(.size16, .helvetica)))
                Spacer()
            }
        }
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

