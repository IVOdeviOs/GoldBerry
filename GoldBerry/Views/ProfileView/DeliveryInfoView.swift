import SwiftUI

struct DeliveryInfoView: View {
    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                Text("Support service")
                    .font(Font(uiFont: .fontLibrary(25, .uzSansBold)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .padding()
                Text("Contact number")
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .foregroundColor(Color.theme.blackWhiteText)
                Text("+375-29-702-37-01")
                    .font(Font(uiFont: .fontLibrary(40, .uzSansBold)))
                    .foregroundColor(Color.theme.lightGreen)
                    .padding(.bottom, 5)
                Text("Payment and delivery")
                    .font(Font(uiFont: .fontLibrary(25, .uzSansBold)))
                    .foregroundColor(Color.theme.blackWhiteText)
                Image(systemName: "rublesign.circle.fill")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .foregroundColor(Color.theme.lightGreen)
                Text("Cash payment")
                    .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .padding(.bottom, 5)
                Text("You can pay for the goods to the courier upon receipt")
                    .font(Font(uiFont: .fontLibrary(15, .uzSansLight)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .minimumScaleFactor(0.5)
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "iphone")
                            .resizable()
                            .frame(width: 50, height: 80)
                            .foregroundColor(.red)
                            .padding(.trailing, -80)
                        Text("Place an order")
                            .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 60)
                        Text("in the application")
                            .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.trailing)
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
                        Text("The courier will contact you\nto clarify the\ndelivery time")
                            .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
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
                        Text("Pay for the order\n upon receipt")
                            .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 60)
                    }
                }
            }
        }
        .background(Color.theme.background)
    }
}
