import Foundation
import SwiftUI
import UIKit
struct OrderCell: View {

    @State var date: String
    @State var dateOrder: String
    @State var number: String
    @State var price: Double
    @State var purchases: [Fruit]
    @State var address: String
    @State var orderCompleted: Bool
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading) {
                    Text(dateOrder)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        .foregroundColor(Color.theme.gray)
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        .padding(.bottom, 1)
                    Text("Заказ № \(number)")
                        .font(Font(uiFont: .fontLibrary(18, .uzSansBold)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.leading, 10)
                    if orderCompleted == true {
                        Text("Заказ выполнен")
                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(5)
                            .background(Color.theme.lightGreen)
                            .cornerRadius(5)
                            .padding(.leading, 10)
                            .padding(.top, 5)
                    } else {
                        Text("Заказ выполняется")
                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(5)
                            .background(Color.red)
                            .cornerRadius(5)
                            .padding(.leading, 10)
                            .padding(.top, 5)
                            .padding(.bottom, 10)
                    }
                }
                Spacer()
                VStack {
                    Text("\(NSString(format: "%.2f", price)) p.")
                        .frame(width: 120, height: 22)
                        .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                        .minimumScaleFactor(0.5)
                        .foregroundColor(.white)
                        .background(Color.theme.lightGreen)
                        .cornerRadius(5)
                        .padding()
                    Spacer()
                }
            }
            Color.theme.gray
                .frame(height: 3)
            ForEach(0 ..< purchases.count) { row in
                HStack {
                    RemoteImageView(
                        url: URL(string: purchases[row].image)!,
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
                    .cornerRadius(5)
                    .padding(.leading, 10)
                    Text(purchases[row].name)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    Spacer()
                    Text("\(NSString(format: "%.1f", purchases[row].count)) ")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    Text("\(NSString(format: "%.2f", purchases[row].itog)) p.")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        .frame(width: 80, height: 20)
                        .padding(.trailing, 10)
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Доставка:")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Text(address)
                            .fixedSize(horizontal: false, vertical: true)
                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    HStack {
                        Text("Дата доставки:")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Text("\(date)")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                            .foregroundColor(Color.theme.blackWhiteText)
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
