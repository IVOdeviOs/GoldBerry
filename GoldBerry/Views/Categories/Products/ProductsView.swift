import SwiftUI
enum CategoriesFruit: String {
    case all
    case watermelon
    case granat
    case fresh
    case fruct
}

struct ProductsView: View {
    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var orderViewModel: OrderViewModel

    @State var tag = CategoriesFruit.all.rawValue

    var body: some View {

        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button {
                            tag = CategoriesFruit.all.rawValue
                        } label: {
                            CategoriesCell(nameImage: CategoriesFruit.all.rawValue, nameCategories: "Все товары")
                        }
                        Button {
                            tag = CategoriesFruit.watermelon.rawValue
                        } label: {
                            CategoriesCell(nameImage: CategoriesFruit.watermelon.rawValue, nameCategories: "Арбуз и дыня")
                        }
                        Button {
                            tag = CategoriesFruit.granat.rawValue

                        } label: {
                            CategoriesCell(nameImage: CategoriesFruit.granat.rawValue, nameCategories: "Гранат")
                        }
                        Button {
                            tag = CategoriesFruit.fruct.rawValue
                        } label: {
                            CategoriesCell(nameImage: CategoriesFruit.fruct.rawValue, nameCategories: "Фрукты")
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.top, 20)
                }
                HStack {
                    Text("Популярные товары")
                        .font(Font(uiFont: .fontLibrary(25, .uzSansBold)))
                        .foregroundColor(Color.theme.lightGreen)
                    Spacer()
                }.padding(.horizontal, 10)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: fruitViewModel.columns, alignment: .center, spacing: 0, pinnedViews: .sectionFooters) {
                            ForEach(fruitViewModel.fruit) { fruits in
                                if fruits.categories == tag {

                                    AllProductsCell(fruit: fruits, fruitViewModel: fruitViewModel)
                                        .padding(.bottom, 30)
                                } else if tag == CategoriesFruit.all.rawValue {
                                    AllProductsCell(fruit: fruits, fruitViewModel: fruitViewModel)
                                        .padding(.bottom, 30)
                                }
                            }

                        }.padding(.bottom, 60)
                            .accessibilityElement()
                    }
                }
                .isLoading(fruitViewModel.isLoading)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}
