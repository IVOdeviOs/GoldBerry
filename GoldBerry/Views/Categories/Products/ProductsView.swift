import SwiftUI

enum categories: String {
    case all
    case watermelon
    case granat
    case fresh
    case fruct
}

struct ProductsView: View {
    @ObservedObject var fruitViewModel: FruitViewModel

    @State var tag = categories.all.rawValue

    var body: some View {

        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button {
                            tag = categories.all.rawValue
                        } label: {
                            CategoriesCell(nameImage: categories.all.rawValue, nameCategories: "Все товары")
                        }
                        Button {
                            tag = categories.watermelon.rawValue
                        } label: {
                            CategoriesCell(nameImage: categories.watermelon.rawValue, nameCategories: "Арбуз и дыня")
                        }
                        Button {
                            tag = categories.granat.rawValue

                        } label: {
                            CategoriesCell(nameImage: categories.granat.rawValue, nameCategories: "Гранат")
                        }
                        Button {
                            tag = categories.fresh.rawValue

                        } label: {
                            CategoriesCell(nameImage: categories.fresh.rawValue, nameCategories: "Фреши и смузи")
                        }
                        Button {
                            tag = categories.fruct.rawValue
                        } label: {
                            CategoriesCell(nameImage: categories.fruct.rawValue, nameCategories: "Фрукты")
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
                                if  fruits.categories == tag {
//                                    NavigationLink {
//                                        InformationProductView(id: fruits.id ?? UUID(),
//                                                               image: fruits.image,
//                                                               name: fruits.name,
//                                                               itog: fruits.itog,
//                                                               cost: fruits.cost,
//                                                               comment: fruits.comment ?? "",
//                                                               favorite: fruits.favorite,
//                                                               count: fruits.count,
//                                                               percent: fruits.percent ?? 1,
//                                                               weightOrPieces: fruits.weightOrPieces,
//                                                               descriptions: fruits.descriptions ?? "",
//                                                               price: fruits.price ?? 1,
//                                                               categories: fruits.categories)
//
//                                    } label: {
                                    AllProductsCell(fruit: fruits, fruitViewModel: fruitViewModel)
                                            .padding(.bottom, 30)
//                                    }
                                } else if tag == categories.all.rawValue {
                                    AllProductsCell(fruit: fruits, fruitViewModel: fruitViewModel)
                                        .padding(.bottom, 30)
                                }
                            }

                        }.padding(.bottom, 60)
                            .accessibilityElement()
                    }
                }
            }
//            .offset( y: -70)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(fruitViewModel: FruitViewModel())
    }
}
