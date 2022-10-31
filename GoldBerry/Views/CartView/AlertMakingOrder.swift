import SwiftUI

struct AlertMakingOrder: View {
    @ObservedObject var orderViewModel = OrderViewModel()
    
    var body: some View {
        ZStack {
            VStack(spacing: 20 ) {
                Text("Ууууппппсссс")
                    .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                    .foregroundColor(Color.red)
                Text("Что-то пошло не так")
                    .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                    .foregroundColor(Color.black)
            }
        }
        .frame(width: 300, height: 300, alignment: .center)
    }
}

struct AlertMakingOrder_Previews: PreviewProvider {
    static var previews: some View {
        AlertMakingOrder()
    }
}
