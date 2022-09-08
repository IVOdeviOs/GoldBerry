import SwiftUI

struct FavouriteProductsView: View {
    
    @StateObject var viewModel = FruitViewModel()
    
    var body: some View {
        VStack {
        Text("Избранные товары")
            .foregroundColor(.black)
            .font(Font(uiFont: .fontLibrary(16, .uzSansBold)))
            .padding()
            Spacer()
        }.background(Color.theme.gray)
    }
}

struct FavouriteProductsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteProductsView()
    }
}
