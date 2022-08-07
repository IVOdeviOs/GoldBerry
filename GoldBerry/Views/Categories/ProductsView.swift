import SwiftUI

struct ProductsView: View {
    var body: some View {
        VStack{
            ScrollView(.horizontal, showsIndicators: true){
                HStack{
                Image(systemName: "iphone")
                    .resizable()
                    .frame(width: 200, height: 200)
                Image(systemName: "iphone")
                    .resizable()
                    .frame(width: 200, height: 200)
                Image(systemName: "iphone")
                    .resizable()
                    .frame(width: 200, height: 200)
                Image(systemName: "iphone")
                    .resizable()
                    .frame(width: 200, height: 200)
                }.padding()
            }
            ScrollView(.vertical, showsIndicators: true) {
                VStack{
                Image(systemName: "cart")
                    .resizable()
                    .frame(width: 200, height: 200)
                Image(systemName: "cart")
                    .resizable()
                    .frame(width: 200, height: 200)
                Image(systemName: "cart")
                    .resizable()
                    .frame(width: 200, height: 200)
                Image(systemName: "cart")
                    .resizable()
                    .frame(width: 200, height: 200)
                }
            }
            .padding(.top,14)
            
            
            
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
