import SwiftUI

struct OrderAdminCell: View {

    @State var date: String
    @State var dateOrder: String
    @State var numberOrder: String
    @State var price: Double
    @State var address: String
    @State var order: String
    @State var phoneNumber: String
    @State var count: String
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
                        Text("\(numberOrder)")
                            .font(Font(uiFont: .fontLibrary(18, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                    }
                }
                Spacer()
                VStack {
                    HStack {
                        Text("$ ")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                            .minimumScaleFactor(0.5)
                            .foregroundColor(.white)
                        Text(" \(NSString(format: "%.2f", price))")
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
                    HStack {
                        Text("Recipient:")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Text("\(order)")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Spacer()
                    }
                    HStack {
                        Text("Phone number:")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Text("\(phoneNumber)")
                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .padding(.bottom, 10)
                            .padding(.leading, 10)
                        Spacer()
                    }
//                    HStack {
//                        Text("Кол-во товаров:")
//                            .font(Font(uiFont: .fontLibrary(16, .uzSansBold)))
//                            .foregroundColor(Color.theme.blackWhiteText)
//                            .padding(.bottom, 10)
//                            .padding(.leading, 10)
//                        Text("\(count)")
//                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
//                            .foregroundColor(Color.theme.blackWhiteText)
//                            .padding(.bottom, 10)
//                            .padding(.leading, 10)
//                        Spacer()
//                    }
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
