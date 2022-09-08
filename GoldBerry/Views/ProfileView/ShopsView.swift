
import SwiftUI

struct ShopsView: View {
    
    @StateObject var viewModel: FruitViewModel
    
    var body: some View {
        VStack {
            Text("Наши торговые точки")
                .foregroundColor(.black)
                .font(Font(uiFont: .fontLibrary(15, .uzSansBold)))
                .padding()
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
            ShopsInfo(viewModel: FruitViewModel(), shopName: "Комаровский рынок, место 181", shopAddress: "г. Минск, ул. В. Хоружей, 8", workTime: "с 08:00 до 20:00")
            ShopsInfo(viewModel: FruitViewModel(), shopName: "Рынок Валерианово, место 14", shopAddress: "г. Минск, ул. Логойская, 5а", workTime: "с 08:00 до 21:00")
            Spacer()
        }
    }
}

struct ShopsView_Previews: PreviewProvider {
    static var previews: some View {
        ShopsView(viewModel: FruitViewModel())
    }
}

struct ShopsInfo: View {
    
    @StateObject var viewModel: FruitViewModel
    @State var shopName: String
    @State var shopAddress: String
    @State var workTime: String
    
    var body: some View {
        VStack {
            HStack {
                Text(shopName)
                    .foregroundColor(.black)
                    .font(Font(uiFont: .fontLibrary(18, .uzSansBold)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("Адрес: \(shopAddress)")
                    .foregroundColor(.black)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("Доставка: 0р.")
                    .foregroundColor(.black)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("Режим работы: \(workTime)")
                    .foregroundColor(Color.theme.gray)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Spacer()
            }
            HStack {
                Text("Режим доставки: \(workTime)")
                    .foregroundColor(Color.theme.gray)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .padding(.leading, 10)
                    .padding(.bottom, 5)
                Spacer()
            }
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 1)
            
            Button {
                viewModel.selected = 0
            }
        label: {
            Text("Перейти к заказу товаров")
                .foregroundColor(.blue)
                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                .padding()
        }
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 5)
        }
    }
}
