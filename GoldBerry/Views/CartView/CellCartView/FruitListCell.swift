
import SwiftUI

struct FruitListCell: View {
    @State var name: String
    @State var cost: Int
    @State var count: Int
    @State var weightOrPieces: String
    var sumCost: Int {
        return (cost * count)
    }

    var body: some View {
        VStack {
            HStack {

                Text(name)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .black, design: .monospaced))
                    .padding(.leading, 30)
                Spacer()
                Text("\(cost) ₽/\(weightOrPieces)")
                    .font(.system(size: 20, weight: .bold, design: .serif))
                    .padding(.trailing, 30)
            }
            HStack {
                Text("\(sumCost) ₽")
                    .font(.system(size: 20, weight: .bold, design: .serif))
                Spacer()
                Button {
                    count -= 1
                    if count <= 0 {
                        count = 0
                    }
                } label: {
                    Image(systemName: "minus.square")
                        .resizable()
                        .background(.gray.opacity(0.3))
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)

                }
                Text("\(count)")
                Button {
                    count += 1
                    if count >= 100 {
                        count = 100
                    }
                } label: {
                    Image(systemName: "plus.square")
                        .resizable()
                        .background(.green)
                        .frame(width: 30, height: 30)
                        .foregroundColor(.black)
                }
            }
        }
        .padding()
        .background(Color.theme.lightGreen.opacity(0.5))
        .cornerRadius(20)
        .padding()
    }
}

struct FruitListCell_Previews: PreviewProvider {
    static var previews: some View {
        FruitListCell(name: "apple", cost: 1200, count: 1, weightOrPieces: "кг")
    }
}
