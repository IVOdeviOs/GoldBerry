
import SwiftUI

struct OrderInfoView: View {
    @ObservedObject var order: Order
    var body: some View {
            
            VStack {
                Text(order.address)
         
                }
            .navigationBarHidden(true)
        }
    
}

struct OrderInfoView_Previews: PreviewProvider {
    static var previews: some View {
        OrderInfoView(order: Order(
            orderNumber: 1,
            fruit: [watermelon],
            date: "18/08/2022",
            address: "Минск",
            price: 1000
        ))
    }
}

