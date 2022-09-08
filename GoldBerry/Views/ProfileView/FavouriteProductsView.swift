import SwiftUI

struct FavouriteProductsView: View {
    @ObservedObject var viewModel: FruitViewModel
    
    var body: some View {

        NavigationView {
            VStack {
                    Text("Избранные товары")
                    .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                        .foregroundColor(.green)
                .padding()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: viewModel.columns, alignment: .center, spacing: 1, pinnedViews: .sectionFooters, content: {
                            ForEach(viewModel.fruit){ fruits in
                                NavigationLink {
                                    InformationProductView(fruit: fruits)
                                } label: {
                                    AllProductsCell(fruit: fruits)
                                        .padding(.bottom, 30)
                                }
                            }

                        }).padding(.bottom, 60)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
       
    }
}

struct FavouriteProductsView_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteProductsView(viewModel: FruitViewModel())
    }
}
