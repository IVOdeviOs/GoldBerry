import SwiftUI

struct OrderCell: View {

    @State var date: String
    @State var number: Int
    @State var price: Double
    @State var purchases: [Fruit]
    @State var address: String

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
                        .font(Font(uiFont: .fontLibrary(18, .uzSansBold)))
                        .foregroundColor(.black)
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
                    RemoteImageView(
                        url: URL(string: purchases[row].image)!,
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
                    Text(purchases[row].name)
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    Spacer()
                    Text("\(purchases[row].count)")
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    Text("\(NSString(format: "%.2f", purchases[row].itog)) p.")
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
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Доставка:")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansBold)))
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Text(address)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    HStack {
                        Text("Дата доставки:")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansBold)))
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Text("\(date)")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                            .foregroundColor(.black)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Spacer()
                    }
                }
                Spacer()
            }
        }
        .background(.gray.opacity(0.1))
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
            purchases: [],
            address: "Минск, пр-т Независимости, 12-100"
        )
    }
}
