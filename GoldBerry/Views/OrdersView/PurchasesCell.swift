//import SwiftUI
//
//struct PurchasesCell: View {
//
//    let imageName: String
//    let name: String
//    let cost: String
//    let count: Int
//    
//    var body: some View {
//        HStack {
//            Image(imageName)
//                .resizable()
//                .frame(width: 50, height: 50)
//                .cornerRadius(10)
//                .padding(.leading, 10)
//            Text(name)
//                .foregroundColor(.black)
//                .font(Font(uiFont: .fontLibrary(.size20, .helvetica)))
//            Spacer()
//                    Text("\(count)")
//                .foregroundColor(.black)
//                .font(Font(uiFont: .fontLibrary(.size20, .helvetica)))
//                    Text("\(cost) p.")
//                .foregroundColor(Color.theme.lightGreen)
//                .font(Font(uiFont: .fontLibrary(.size20, .helvetica)))
//                .padding(.trailing, 10)
//                }
//                .listStyle(.plain)
//            }
//}
//            
//      
//
//struct PurchasesCell_Previews: PreviewProvider {
//    static var previews: some View {
//        PurchasesCell(
//            imageName: "watermelon",
//            name: "Watermelon",
//            cost: "1000",
//            count: 1
//        )
//    }
//}
//
