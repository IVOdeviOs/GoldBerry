

import SwiftUI


struct OrdersView: View {
    
    @State var orders = [Fruit]()

    var body: some View {
        if orders.isEmpty {
            WithoutOrders()
        } else {
            Text("ds")
        }
    }
}

struct WithoutOrders: View {
    var body: some View {
        VStack {
            Image("noOrders")
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(20)
                .padding()
                .padding(.top, 90)
            Text("У вас пока нет заказов")
                .font(Font(uiFont: .fontLibrary(.size24, .helvetica)))
            Text("Закажите что-нибудь свеженькое в нашем магазине")
                .font(Font(uiFont: .fontLibrary(.size16, .helvetica)))
                .padding()
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.gray)
            NavigationLink {
                ContentView()
            } label: {
                Text("Перейти к выбору товаров")
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .font(Font(uiFont: .fontLibrary(.size20, .helvetica)))
                    .background(Color.theme.lightGreen)
                    .cornerRadius(10)
            }
            Spacer()
                .navigationBarHidden(true)
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}

