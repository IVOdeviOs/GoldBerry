import SwiftUI

struct CompletedOrderView: View {
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var fruitViewModel = FruitViewModel()
    var body: some View {
        Text("Thanks for the order!")
        Text("The courier will contact you soon")
        Image("completedOrder")
            .resizable()
            .frame(width: 270, height: 200)
            .cornerRadius(15)
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
