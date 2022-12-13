import SwiftUI

struct CompletedOrderView: View {
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var fruitViewModel = FruitViewModel()
    var body: some View {
        Text("Спасибо за заказ!")
        Text("Курьер свяжется с Вами в ближайшее время")
        Image("completedOrder")
            .resizable()
            .frame(width: 300, height: 300)
            .onDisappear{
                fruitViewModel.uniqFruits.removeAll()
            }
    }
}

struct CompletedOrderView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedOrderView()
    }
}
