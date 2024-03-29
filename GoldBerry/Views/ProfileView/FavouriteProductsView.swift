import SwiftUI

struct FavouriteProductsView: View {

    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var userViewModel: UserViewModel
    @FetchRequest(entity: FavoriteFruit.entity(), sortDescriptors: [])
    var favoriteFruit: FetchedResults<FavoriteFruit>
    var body: some View {

        if favoriteFruit.isEmpty {
            WithoutFavouriteProductsView(fruitViewModel: fruitViewModel, userViewModel: userViewModel)
        } else {
            WithFavouriteProductsView(userViewModel: userViewModel, fruitViewModel: fruitViewModel)
        }
    }
}

struct WithoutFavouriteProductsView: View {
    @StateObject var fruitViewModel: FruitViewModel
    @StateObject var userViewModel: UserViewModel

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    userViewModel.showFavouriteProductsView = false
                } label: {
                    Image(systemName: "x.square")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(.red)
                }
                .padding(.top,20)
                .padding(.trailing,16)
            }
            Image("noOrders")
                .resizable()
                .frame(width: 300, height: 300)
                .cornerRadius(20)
                .padding()
                .padding(.top, 90)
            Text("No featured products")
                .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.bottom, 10)
            Text("Add products so you don't miss anything important")
                .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                .padding(.bottom, 10)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.theme.grafit)
            Button {
                fruitViewModel.selected = 0
            } label: {
                Text("Go to product selection")
                    .frame(width: 300, height: 50)
                    .foregroundColor(.white)
                    .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                    .background(Color.theme.green4)
                    .cornerRadius(10)
            }
            Spacer()
                .navigationBarHidden(true)
        }
    }
}

struct WithFavouriteProductsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var userViewModel: UserViewModel
    @ObservedObject var fruitViewModel: FruitViewModel
    @FetchRequest(entity: FavoriteFruit.entity(), sortDescriptors: [])
    var favoriteFruit: FetchedResults<FavoriteFruit>
    @State var favorite = [Fruit]()
//    @State var uniqFavorite = [Fruit]()

    var body: some View {

        NavigationView {
            VStack {
                HStack {
                    Spacer()
                    Text("Featured Products")
                        .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                        .foregroundColor(Color.theme.lightGreen)
                        .padding()
                    Spacer()
                    Button {
                        userViewModel.showFavouriteProductsView = false
                    } label: {
                        Image(systemName: "x.square")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.red)
                    }
                    .padding(.trailing,16)
                    
                  
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: fruitViewModel.columns, alignment: .center, spacing: 1, pinnedViews: .sectionFooters, content: {
                            ForEach(fruitViewModel.favoriteFruits, id: \.id) { fruit in
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

            Task {
                do {
                    try await fruitViewModel.fetchFruit()
                } catch {}
            }

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
