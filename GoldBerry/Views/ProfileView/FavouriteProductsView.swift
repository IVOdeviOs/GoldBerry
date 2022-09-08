import SwiftUI

struct FavouriteProductsView: View {
    
    @StateObject var viewModel = FruitViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct FavouriteProductsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteProductsView()
    }
}
