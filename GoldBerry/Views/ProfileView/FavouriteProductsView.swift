import SwiftUI

struct FavouriteProductsView: View {

    @ObservedObject var fruitViewModel: FruitViewModel
    @FetchRequest(entity: FavoriteFruit.entity(), sortDescriptors: [])
    var favoriteFruit: FetchedResults<FavoriteFruit>
    var body: some View {

        if favoriteFruit.isEmpty {
            WithoutFavouriteProductsView(fruitViewModel: fruitViewModel)
        } else {
            WithFavouriteProductsView(fruitViewModel: fruitViewModel)
        }
    }
}

struct WithoutFavouriteProductsView: View {
    @StateObject var fruitViewModel: FruitViewModel

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
                fruitViewModel.selected = 0
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
    @Environment(\.managedObjectContext) private var viewContext

    @ObservedObject var fruitViewModel: FruitViewModel
    @FetchRequest(entity: FavoriteFruit.entity(), sortDescriptors: [])
    var favoriteFruit: FetchedResults<FavoriteFruit>
    @State var favorite = [Fruit]()
//    @State var uniqFavorite = [Fruit]()

    var body: some View {

        NavigationView {
            VStack {
                Text("Избранные товары")
                    .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                    .foregroundColor(Color.theme.lightGreen)
                    .padding()

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: fruitViewModel.columns, alignment: .center, spacing: 1, pinnedViews: .sectionFooters, content: {
                            ForEach(fruitViewModel.favoriteFruits, id:\.id) { fruit in
                                FavoriteProductCell(fruitViewModel: fruitViewModel, fruit: fruit)
                                    .padding(.bottom, 30)
                            }

                        }).padding(.bottom, 60)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .onAppear {
            for item in favoriteFruit {
                for i in fruitViewModel.fruit {
                    if item.id == i.id {
                        favorite.append(i)
                        fruitViewModel.favoriteFruits = uniq(source: favorite)
                    }
                }
            }
        }
    }
}

private func uniq<S: Sequence, T: Hashable>(source: S) -> [T] where S.Iterator.Element == T {
    var buffer = [T]()
    var added = Set<T>()
    for elem in source {
        if !added.contains(elem) {
            buffer.append(elem)
            added.insert(elem)
        }
    }
    return buffer
}
