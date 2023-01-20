import SwiftUI

struct ProductViewCell: View {
    @State var fruit: Fruit
    @ObservedObject var adminViewModel: AdminViewModel

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .bottomLeading) {
                if fruit.favorite {
                    VStack{
                        Text("The product is hidden")
                            .font(.system(size: 20, weight: .light, design: .serif))
                    }
                    .frame(width: 180, height: 120, alignment: .center)
                    .background(Color.gray.opacity(0.5))
                }else {
                    AsyncImage(
                        url: URL(string: fruit.image),
                        transaction: Transaction(animation: .none)
                    ) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image
                                .resizable()
                                .transition(.scale(scale: 0.1, anchor: .center))
                                .frame(width: 180, height: 120)
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            Image(systemName: "wifi.slash")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 180, height: 120)
                
                if fruit.percent != 0 {
                    Text("-\(fruit.percent)%")
                        .font(.system(size: 12, weight: .light, design: .serif))
                        .foregroundColor(.white)
                        .frame(width: 35, height: 20)
                        .padding(.horizontal, 5)
                        .background(.red)
                        .cornerRadius(20)
                        .padding(5)
                }
            }
            }
            HStack {
                if fruit.itog == fruit.cost {
                    Text("$\(fruit.cost, specifier: "%.2f")")
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.theme.blackWhiteText)
                    Spacer()
                } else {
                    Text("$\(fruit.itog, specifier: "%.2f")")
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.red)
                    ZStack {
                        Text("$\(fruit.cost, specifier: "%.2f")")
                            .font(.system(size: 12, weight: .light, design: .serif))
                            .foregroundColor(Color.theme.blackWhiteText.opacity(0.6))
                            .multilineTextAlignment(.leading)
                        Color.theme.blackWhiteText.opacity(0.5)
                            .frame(width: 45, height: 1)
                    }

                    Spacer()
                }
            }.padding(.horizontal, 5)

            HStack {
                Text(fruit.name)
                    .font(.system(size: 18, weight: .light, design: .serif))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(3)
            .cornerRadius(10)
            .padding(.horizontal, 3)
            HStack(alignment: .top) {
                Text(fruit.comment)
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .foregroundColor(Color.theme.blackWhiteText.opacity(0.8))
                Spacer()
            }
            .padding(.horizontal, 5)
            .frame(height: 60)

            HStack {
                NavigationLink {
                    AddFruit(adminViewModel: adminViewModel,
                             idFruit: fruit.id!,
                             productName: fruit.name,
                             productDescription: fruit.comment,
                             productPrice: String(fruit.cost),
                             productDiscount: String(fruit.percent),
                             productCategories: fruit.categories,
                             weightOrPieces: fruit.weightOrPieces,
                             productImage: fruit.image,
                             productFavorite: fruit.favorite)
                        .navigationBarBackButtonHidden(true)
                        .onAppear {
                            adminViewModel.isUpdating = true
                            
                        }
                } label: {
                    ZStack {
                        Text("Edit")
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .light, design: .serif))
                    }
                    .frame(width: 140, height: 25)
                    .background(Color.theme.lightGreen)
                    .cornerRadius(6)
                    .padding(8)
                    .shadow(color: Color.theme.blackWhiteText, radius: 2)
                }
            }
            .padding(7)
        }

        .frame(width: 180, height: 295)
        .background(Color.theme.background)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 1, x: 0, y: 2)
    }
}
