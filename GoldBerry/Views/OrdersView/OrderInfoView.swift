
import SwiftUI

struct OrderInfoView: View {
    
    @ObservedObject var order: Order
    @Environment(\.presentationMode) var presentation

    var body: some View {
            
            VStack {
                Text(order.address)
                }
            .navigationBarHidden(true)
            .navigationBarItems(leading:
                Image(systemName: "arrow.backward")
                .resizable()
                .frame(width: 25, height: 18)
             .foregroundColor(.black)
                .onTapGesture {
                   self.presentation.wrappedValue.dismiss()
                }
             )
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

