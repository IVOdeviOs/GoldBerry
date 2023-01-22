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
                    HStack {
                        Text("Order №")
                            .font(Font(uiFont: .fontLibrary(18, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(.leading, 10)
                        Text("\(number)")
                            .font(Font(uiFont: .fontLibrary(18, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    if orderCompleted == true {
                        Text("Order completed")
                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(5)
                            .background(Color.theme.lightGreen)
                            .cornerRadius(5)
                            .padding(.leading, 10)
                            .padding(.top, 5)
                    } else {
                        Text("Order in progress")
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
                    HStack {
                        Text("\(NSString(format: "%.2f", price))")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                        Text("$ ")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                    }
                    .frame(width: 120, height: 22)
                    .background(Color.theme.lightGreen)
                    .cornerRadius(5)
                    .padding()
                    Spacer()
                }
            }
            Color.theme.gray
                .frame(height: 3)
            HStack {
                Spacer()
                Text("Product name")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    .frame(width: UIScreen.main.bounds.width / 4, height: 20)
                Text("Price")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    .frame(width: UIScreen.main.bounds.width / 7, height: 20)
                Text("Count")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    .frame(width: UIScreen.main.bounds.width / 7, height: 20)
                Text("Total")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                    .frame(width: UIScreen.main.bounds.width / 7, height: 20)
                    .padding(.trailing, 10)
            }
            ForEach(0 ..< purchases.count) { row in
                if purchases[row].favorite {} else {

                    HStack {
                        AsyncImage(
                            url: URL(string: purchases[row].image),
                            transaction: Transaction(animation: .easeInOut)
                        ) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .transition(.scale(scale: 0.1, anchor: .center))
                                    .frame(width: 30, height: 20)
                                    .aspectRatio(contentMode: .fill)
                            case .failure:
                                Image(systemName: "wifi.slash")
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .frame(width: 30, height: 20)
                        .cornerRadius(5)
                        .padding(.leading, 10)
                        Text(purchases[row].name)
                            .foregroundColor(Color.theme.blackWhiteText)
                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                            .frame(width: UIScreen.main.bounds.width / 4, height: 20)
                            .minimumScaleFactor(0.7)
                        HStack(spacing: 1) {
                            Text("$ ")
                                .foregroundColor(Color.theme.blackWhiteText)
                                .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                            Text(" \(NSString(format: "%.2f", purchases[row].itog))")
                                .foregroundColor(Color.theme.blackWhiteText)
                                .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        }
                        .frame(width: UIScreen.main.bounds.width / 7, height: 20)
                        Text("\(NSString(format: "%.1f", purchases[row].count)) ")
                            .foregroundColor(Color.theme.blackWhiteText)
                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                            .frame(width: UIScreen.main.bounds.width / 7, height: 20)
                        HStack(spacing: 1) {
                            Text("$ ")
                                .foregroundColor(Color.theme.blackWhiteText)
                                .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                            Text(" \(NSString(format: "%.2f", purchases[row].itog * Double(purchases[row].count)))")
                                .foregroundColor(Color.theme.blackWhiteText)
                                .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                        }
                        .frame(width: UIScreen.main.bounds.width / 7, height: 20)
                        .padding(.trailing, 10)
                    }
                }
            }
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Delivery:")
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
                        Text("Delivery date:")
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
