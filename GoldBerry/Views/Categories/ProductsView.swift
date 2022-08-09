import SwiftUI

struct ProductsView: View {
    @ObservedObject var viewModel = TabBarViewModel()

    var body: some View {

        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    CategoriesCell(nameImage: "watermelon", nameCategories: "Арбуз и Дыня")
                    CategoriesCell(nameImage: "granat", nameCategories: "Гранат")
                    CategoriesCell(nameImage: "fresh", nameCategories: "Фреши и смузи")
                    CategoriesCell(nameImage: "fruct", nameCategories: "Фрукты")
                }
                .padding(.horizontal, 10)
                .padding(.top)
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
                        ForEach(0 ..< 10) { _ in
                            NavigationLink {
                                InformationProductView()
                            } label: {
                                AllProductsCell()
                                    .padding(.bottom, 30)
                            }
                        }
                    }).padding(.bottom, 100)
                }
            }
        }
    }
}

struct ProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView()
    }
}
