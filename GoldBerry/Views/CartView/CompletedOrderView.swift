import SwiftUI

struct CompletedOrderView: View {
    var body: some View {
        Text("Спасибо за заказ!")
        Text("Курьер свяжется с Вами в ближайшее время")
        Image("completedOrder")
            .resizable()
            .frame(width: 300, height: 300)
    }
}

struct CompletedOrderView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedOrderView()
    }
}
