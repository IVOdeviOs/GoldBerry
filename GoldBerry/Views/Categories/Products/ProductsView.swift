import SwiftUI

enum categories: String {
    case watermelon
    case granat
    case fresh
    case fruct
}

struct ProductsView: View {
    @ObservedObject var viewModel: FruitViewModel
    
    @State var tag = "watermelon"
    
    var body: some View {

        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
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
                    .padding(.top, 0)
                }
                HStack {
                    Text("Популярные товары")
                        .font(.system(size: 25, weight: .ultraLight, design: .rounded))
                        .foregroundColor(.green)
                    Spacer()
                }.padding(.horizontal, 10)

                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: viewModel.columns, alignment: .center, spacing: 1, pinnedViews: .sectionFooters, content: {
                            ForEach(viewModel.fruit){ fruits in
                                if fruits.categories == tag {
                                    NavigationLink {
                                        InformationProductView(image: fruits.image,
                                                               name: fruits.name,
                                                               itog: fruits.itog,
                                                               cost: fruits.cost,
                                                               comment: fruits.comment ?? "",
                                                               favorite: fruits.favorite,
                                                               count: fruits.count,
                                                               percent: fruits.percent ?? 1,
                                                               weightOrPieces: fruits.weightOrPieces,
                                                               descriptions: fruits.descriptions ?? "",
                                                               price: fruits.price ?? 1,
                                                               categories: fruits.categories)
                                    } label: {
                                        AllProductsCell(fruit: fruits)

                                            .padding(.bottom, 30)
                                    }
                                   
                                    
                                    
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
