import SwiftUI

struct CartCell: View {
    
    @ObservedObject var viewModel = FruitViewModel()
    @State var imageName: String
    @State var cost: Double
    @State var name: String
    @State var index: String
    @State var description: String
    @State var count: Int
    @State var price: Double
    
    var body: some View {
        VStack {
            HStack {
                Image(imageName)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)
                    .padding(.leading, 10)
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(NSString(format: "%.2f", cost)) р/кг")
                        .foregroundColor(Color.theme.lightGreen)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                    Text(name)
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                    Text(description)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(14, .uzSansRegular)))
                }
                Spacer()
            }
            Button {
                //                viewModel.order.fruit.remove(at: index)
//                onDelete(perform: delete)
            } label: {
                Text("Удалить")
                    .foregroundColor(Color.theme.gray)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
            }
            HStack {
                Button {
                    if count >= 2 {
                        
                        
                        count -= 1
                        if price == 0 {
                            price = cost
                        } else {
                        price = cost * Double(count)
                        }
                    
//                        viewModel.order.price -= price
//                        print("\(price)")
                        viewModel.price = price
                        print("\(viewModel.price)")
                    }
                } label: {
                    Image(systemName: "minus.square.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.theme.gray)
                }
                Text("\(count) кг")
                    .foregroundColor(.black)
                    .font(Font(uiFont: .fontLibrary(24, .uzSansRegular)))
                Button {
                    count += 1
                    if price == 0 {
                        price = cost
                    } else {
                    price = cost * Double(count)
                    }
//                    viewModel.order.price += price
//                    print("\(price)")
                    viewModel.price = price
                    print("\(viewModel.price)")

                } label: {
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.theme.lightGreen)
                }
            }
            HStack {
                Text("Итого: \(NSString(format: "%.2f", price )) р")
                    .foregroundColor(Color.theme.lightGreen)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                    .padding(.leading, 10)
                Spacer()
            }
        }
        .onAppear{
            if price == 0 {
                price = cost
            } else {
            price = cost * Double(count)
            }
            
        }
        .padding()
        .background(.gray.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.theme.gray, lineWidth: 2)
        )
        .cornerRadius(20)
    }
//    func delete(at offsets: IndexSet) {
//        viewModel.order1.fruit.remove(atOffsets: offsets)
//      }
}

struct CartCell_Previews: PreviewProvider {
    static var previews: some View {
        CartCell(
            imageName: "apple",
            cost: 1,
            name: "Apple",
            index: "1",
            description: "Apple 2022",
            count: 1,
            price: 1
        )
    }
}
