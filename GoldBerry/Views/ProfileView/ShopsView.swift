
import SwiftUI

struct ShopsView: View {

    @StateObject var fruitViewModel: FruitViewModel

    var body: some View {
        VStack {
            Text("Адреса торговых точек")
                .foregroundColor(Color.theme.blackWhiteText)
                .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                .padding()
            Color.theme.grafit
                .opacity(0.3)
                .frame(height: 10)
            ShopsInfo(fruitViewModel: fruitViewModel, shopName: "АЗС №2", shopAddress: "д. Боровая, 7", workTime: "10:00-18:00", deliveryTime: "10:00-23:00")
            ShopsInfo(fruitViewModel: fruitViewModel, shopName: "АЗС №18", shopAddress: "Минский р-н, трасса на г. Могилев (М4)", workTime: "10:00-18:00", deliveryTime: "10:00-23:00")
            Spacer()
        }
    }
}

struct ShopsInfo: View {

    @ObservedObject var fruitViewModel: FruitViewModel
    @State var shopName: LocalizedStringKey
    @State var shopAddress: LocalizedStringKey
    @State var workTime: String
    @State var deliveryTime: String


    var body: some View {
        VStack {
            HStack {
                Text(shopName)
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(18, .pFBeauSansProSemiBold)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                HStack {
                    Text("The address:")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                        .padding(.leading, 10)
                        .padding(.bottom, 5)
                    Text(shopAddress)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                        .padding(.bottom, 5)
                }
                Spacer()
            }
//            HStack {
//                Text("Delivery:")
//                    .foregroundColor(Color.theme.blackWhiteText)
//                    .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
//                    .padding(.leading, 10)
//                    .padding(.bottom, 5)
//                Text("C")
//                    .foregroundColor(Color.theme.blackWhiteText)
//                    .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
//                    .padding(.bottom, 5)
//                Spacer()
//            }
            HStack {
                Text("Working mode:")
                    .foregroundColor(Color.theme.grafit)
                    .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Text("\(workTime)")
                    .foregroundColor(Color.theme.grafit)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("Delivery mode:")
                    .foregroundColor(Color.theme.grafit)
                    .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Text("\(deliveryTime)")
                    .foregroundColor(Color.theme.grafit)
                    .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                    .padding(.bottom, 5)
                Spacer()
            }
            Color.theme.grafit
                .opacity(0.3)
                .frame(height: 1)

            Button {
                fruitViewModel.selected = 0
            }
        label: {
                Text("Go to ordering goods")
                    .foregroundColor(Color.theme.green4)
                    .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                    .padding()
            }
            Color.theme.grafit
                .opacity(0.3)
                .frame(height: 5)
        }
    }
}
