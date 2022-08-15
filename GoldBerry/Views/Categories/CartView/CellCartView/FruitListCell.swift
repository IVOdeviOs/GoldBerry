
import SwiftUI

struct FruitListCell: View {
    var name: String
    var cost: String
    var count: Int
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(cost)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .black, design: .monospaced))
                Spacer()
            }
            HStack {
                Text(name)
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .black, design: .monospaced))
                Spacer()
                Text("\(count)")
                    .foregroundColor(.black)
                    .font(.system(size: 20, weight: .black, design: .monospaced))
            }
        }
        .padding()
        .background(.red)
        .padding()
    }
}

struct FruitListCell_Previews: PreviewProvider {
    static var previews: some View {
        FruitListCell(name: "apple", cost: "12", count: 1)
    }
}
