import SwiftUI

struct FavouriteProductsViewCell: View {
    @State var fruit: Fruit

    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .bottomLeading) {

                RemoteImageView(
                    url: URL(string: fruit.image)!,
                    placeholder: {
                        Image(systemName: "icloud.and.arrow.up").frame(width: 300, height: 300)
                    },
                    image: {
                        $0
                            .resizable()
                            .frame(width: 180, height: 180)
                            .aspectRatio(contentMode: .fit)
                    }
                )

                Text("-\(fruit.percent!)%")
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .foregroundColor(.white)
                    .frame(width: 35, height: 20)
                    .padding(.horizontal, 5)
                    .background(.red)
                    .cornerRadius(20)
                    .padding(5)
            }
            HStack {
                Text("\(fruit.itog, specifier: "%.2f")₽")
                    .font(.system(size: 14, weight: .bold, design: .serif))
                    .foregroundColor(.red)
                ZStack {
                    Text("\(fruit.cost, specifier: "%.2f")₽")
                        .font(.system(size: 12, weight: .light, design: .serif))
                        .foregroundColor(.black.opacity(0.6))
                    Color(CGColor(gray: 0, alpha: 1)).opacity(0.5)
                        .frame(width: 45, height: 0.5)
                }

                Spacer()
            }.padding(.horizontal, 5)
            HStack {
                Text(fruit.name)
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .foregroundColor(.black)

                Spacer()
            }
            .padding(.horizontal, 5)
            HStack {
                Text(fruit.comment ?? "no")
                    .frame(width: 170, height: 60)
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .foregroundColor(.black.opacity(0.8))
            }

            HStack {
                Text("Доставка:0₽")
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .foregroundColor(.black.opacity(0.7))
                Spacer()
            }
            .padding(.horizontal, 10)
            Spacer()
        }
        .frame(width: 180, height: 290)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 1, x: 0, y: 2)
    }
}

struct FavouriteProductsViewCell_Previews: PreviewProvider {
    static var previews: some View {
        FavouriteProductsViewCell(fruit:  Fruit( cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1, description: "", price: 1)).previewLayout(.fixed(width: 180, height: 290))
    }
}
