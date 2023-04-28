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

                ZStack {
                    if fruitViewModel.alertFavorite {
                        withAnimation {
                            ZStack {
                                VStack {
                                    HStack {
                                        Text("To add a product to favorites, you need to Log in or Register")
                                            .font(Font(uiFont: UIFont.fontLibrary(16, .pFBeauSansProRegular)))
                                            .foregroundColor(Color.theme.background)
                                            .frame(width: 300)
                                            .padding(5)
                                        Spacer()
                                        Button {
                                            fruitViewModel.alertFavorite = false
                                        } label: {
                                            Image(systemName: "x.square")
                                                .resizable()
                                                .frame(width: 25, height: 25)
                                                .foregroundColor(Color.theme.background)
                                        }
                                        .padding(5)
                                    }
                                    Button {
                                        fruitViewModel.presentedAuth.toggle()
//                                        LoginView(signUP: LogIn())

                                    } label: {
                                        Text("Login or Register")
                                            .foregroundColor(.white)
                                            .font(Font(uiFont: UIFont.fontLibrary(16, .pFBeauSansProRegular)))
                                            .frame(width: UIScreen.main.bounds.width - 60, height: 30)
                                            .background(Color.theme.green4)
                                            .cornerRadius(10)
                                    }.padding(5)
                                }
                                .padding(5)
                            }
                            .frame(width: 375, height: 120)
                            .background(Color.theme.orange)
                            .cornerRadius(10)
                            .zIndex(1)
                        }
                        .offset(y: 30)
                    }
//                    ScrollView(.horizontal, showsIndicators: false) {
//
//                        HStack {
//                            Button {
//                                tag = CategoriesFruit.all.rawValue
//                            } label: {
//                                CategoriesCell(nameImage: CategoriesFruit.all.rawValue, nameCategories: "All goods")
//                            }
//                            Button {
//                                tag = CategoriesFruit.watermelon.rawValue
//                            } label: {
//                                CategoriesCell(nameImage: CategoriesFruit.watermelon.rawValue, nameCategories: "Watermelon and melon")
//                            }
//                            Button {
//                                tag = CategoriesFruit.granat.rawValue
//
//                            } label: {
//                                CategoriesCell(nameImage: CategoriesFruit.granat.rawValue, nameCategories: "Garnet")
//                            }
//                            Button {
//                                tag = CategoriesFruit.fruct.rawValue
//                            } label: {
//                                CategoriesCell(nameImage: CategoriesFruit.fruct.rawValue, nameCategories: "Fruit")
//                            }
//                            
//                        }
//                        .padding(.horizontal, 10)
//                        .padding(.top, 20)
//                    }
                }
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: fruitViewModel.columns, alignment: .center, spacing: 0, pinnedViews: .sectionFooters) {
                            ForEach(fruitViewModel.fruit) { fruits in
                              
                                if fruits.favorite == false {
                                if fruits.categories == tag {
                                    
                                    AllProductsCell(fruit: fruits, fruitViewModel: fruitViewModel)
                                        .padding(.bottom, 30)
                                    
                                } else if tag == CategoriesFruit.all.rawValue {
                                    AllProductsCell(fruit: fruits, fruitViewModel: fruitViewModel)
                                        .padding(.bottom, 30)
                                }
                            }
                            }

                        }.padding(.bottom, 60)
                            .accessibilityElement()
                    }
                }
                .padding(.top, 26)
                .isLoading(fruitViewModel.isLoading)
            }
            .fullScreenCover(isPresented: $fruitViewModel.presentedAuth, content: {
                LoginView(signUP: LogIn(), fruitViewModel: fruitViewModel)

            })
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
    }
}
