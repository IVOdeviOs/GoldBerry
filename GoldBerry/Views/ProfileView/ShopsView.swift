
import SwiftUI

struct ShopsView: View {

    @StateObject var fruitViewModel: FruitViewModel

    var body: some View {
        VStack {
            Text("Адреса торговых точек")
                .foregroundColor(Color.theme.blackWhiteText)
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .padding()
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
            ShopsInfo(fruitViewModel: fruitViewModel, shopName: "Shop #1, place #1", shopAddress: "Washington", workTime: "08:00-20:00")
            ShopsInfo(fruitViewModel: fruitViewModel, shopName: "Shop #2, place #2", shopAddress: "New York", workTime: "08:00-21:00")
            Spacer()
        }
    }
}

struct ShopsInfo: View {

    @ObservedObject var fruitViewModel: FruitViewModel
    @State var shopName: LocalizedStringKey
    @State var shopAddress: LocalizedStringKey
    @State var workTime: String

    var body: some View {
        VStack {
            HStack {
                Text(shopName)
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(18, .uzSansBold)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                HStack {
                    Text("The address:")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        .padding(.leading, 10)
                        .padding(.bottom, 5)
                    Text(shopAddress)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        .padding(.bottom, 5)
                }
                Spacer()
            }
            HStack {
                Text("Delivery:")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Text("$0")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("Working mode:")
                    .foregroundColor(Color.theme.gray)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Text("\(workTime)")
                    .foregroundColor(Color.theme.gray)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("Delivery mode:")
                    .foregroundColor(Color.theme.gray)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Text("\(workTime)")
                    .foregroundColor(Color.theme.gray)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.bottom, 5)
                Spacer()
            }
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 1)

            Button {
                fruitViewModel.selected = 0
            }
        label: {
                Text("Go to ordering goods")
                    .foregroundColor(Color.theme.lightGreen)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                    .padding()
            }
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 5)
        }
    }
}
