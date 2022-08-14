import SwiftUI

struct AllProductsCell: View {
    var body: some View {
        VStack(spacing: 10) {
            ZStack(alignment: .bottomLeading) {
                Image(systemName: "plus")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 120)
                    .background(.green)
                Text("-15%")
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .foregroundColor(.white)
                    .frame(width: 30, height: 20)
                    .padding(.horizontal, 5)
                    .background(.red)
                    .cornerRadius(20)
                    .padding(5)
            }
            HStack {
                Text("3500₽")
                    .font(.system(size: 14, weight: .bold, design: .serif))
                    .foregroundColor(.red)
                ZStack {
                    Text("4500₽")
                        .font(.system(size: 12, weight: .light, design: .serif))
                        .foregroundColor(.black.opacity(0.6))
                    Color(CGColor(gray: 0, alpha: 1)).opacity(0.5)
                        .frame(width: 45, height: 0.5)
                }

                Spacer()
            }.padding(.horizontal, 5)
            HStack {
                Text("Название Фруктов")
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .foregroundColor(.black)
                    
                Spacer()
            }
            .padding(.horizontal, 5)
            HStack {
                Text("maksdgnaskdkjnhgkyguygougouygouygouygkugugugouygouygoluygkigasdknkjasdngsdnkansddsafdsakadskfjsadfasdjfdosafjadsojfdsoifasdifjoasdifodsiajf")
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
            .padding(.horizontal,10)
            Spacer()
        }
        .frame(width: 180, height: 290)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 1, x: 0, y: 2)
    }
}

struct AllProductsCell_Previews: PreviewProvider {
    static var previews: some View {
        AllProductsCell().previewLayout(.fixed(width: 180, height: 290))
    }
}
