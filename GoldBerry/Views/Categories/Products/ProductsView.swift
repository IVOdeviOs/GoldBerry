import SwiftUI

enum categories: String {
    case all
    case watermelon
    case granat
    case fresh
    case fruct
}

struct ProductsView: View {
    @ObservedObject var viewModel: FruitViewModel

    @State var tag = ""

    var body: some View {

        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        Button {
                            tag = "allFruits"
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
                        .foregroundColor(.green)
                    Spacer()
                }.padding(.horizontal, 10)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: viewModel.columns, alignment: .center, spacing: 0, pinnedViews: .sectionFooters, content: {
                            ForEach(viewModel.fruit) { fruits in
                                if fruits.categories == tag {
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
                                        AllProductsCell(fruit: fruits)
                                            .padding(.bottom, 30)
//                                    }
                                } else if tag == "allFruits" {
                                    AllProductsCell(fruit: fruits)
                                        .padding(.bottom, 30)
                                }
                            }

                        }).padding(.bottom, 60)
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
        ProductsView(viewModel: FruitViewModel())
    }
}
