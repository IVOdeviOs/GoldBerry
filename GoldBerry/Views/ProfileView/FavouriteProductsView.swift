import SwiftUI

struct FavouriteProductsView: View {

    @ObservedObject var viewModel: FruitViewModel

    var body: some View {

        if viewModel.favouriteProducts.isEmpty {
            WithoutFavouriteProductsView(viewModel: viewModel)
        } else {
            WithFavouriteProductsView(fruitViewModel: viewModel)
        }
    }
}

struct WithoutFavouriteProductsView: View {
    @StateObject var viewModel: FruitViewModel

    var body: some View {
        VStack {
            Image("noOrders")
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(20)
                .padding()
                .padding(.top, 90)
            Text("Нет избранных товаров")
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.bottom, 10)
            Text("Добавьте товары, чтобы не пропустить ничего важного")
                .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.gray)
            Button {
                viewModel.selected = 0
            } label: {
                Text("Перейти к выбору товаров")
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    .background(Color.theme.lightGreen)
                    .cornerRadius(10)
            }
            Spacer()
                .navigationBarHidden(true)
        }
    }
}

struct WithFavouriteProductsView: View {

    @ObservedObject var fruitViewModel: FruitViewModel

    var body: some View {

        NavigationView {
            VStack {
                Text("Избранные товары")
                    .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                    .foregroundColor(.green)
                    .padding()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: fruitViewModel.columns, alignment: .center, spacing: 1, pinnedViews: .sectionFooters, content: {
                            ForEach(fruitViewModel.fruit) { fruits in
                                
//                                NavigationLink {
//                                    InformationProductView(
//                                        id: fruits.id ?? UUID() ,
//                                        image: fruits.image,
//                                        name: fruits.name,
//                                        itog: fruits.itog,
//                                        cost: fruits.cost,
//                                        comment: fruits.comment ?? "",
//                                        favorite: fruits.favorite,
//                                        count: fruits.count,
//                                        percent: fruits.percent ?? 0,
//                                        weightOrPieces: fruits.weightOrPieces,
//                                        descriptions: fruits.descriptions ?? "",
//                                        price: fruits.price ?? 1,
//                                        categories: fruits.categories
//                                    )
//                                } label: {
                                AllProductsCell(fruit: fruits, fruitViewModel: fruitViewModel)
                                        .padding(.bottom, 30)
//                                }
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
