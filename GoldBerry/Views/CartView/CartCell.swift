import SwiftUI

struct CartCell: View {
//    @ObservedObject var viewModel: FruitViewModel

    @ObservedObject var viewModel: FruitViewModel
    @State var fruit: Fruit

//    @State var imageName: String
//    @State var cost: Double
//    @State var name: String
//    @State var index: String
//    @State var description: String
//    @State var count: Int
//    @State var price: Double
//    @State var id = UUID()
//

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.id, ascending: true)])
    var fruits: FetchedResults<FruitEntity>

    var body: some View {
        VStack {
            HStack {
                ZStack(alignment: .top) {
                    RemoteImageView(
                        url: URL(string: fruit.image)!,
                        placeholder: {
                            Image(systemName: "icloud.and.arrow.up").frame(width: 300, height: 300)
                        },
                        image: {
                            $0
                                .resizable()
                                .frame(width: 150, height: 150)
                                .aspectRatio(contentMode: .fit)
                        }
                    )
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: UIScreen.main.bounds.width - 20 ,height:350)
                }
                .frame(width: 150, height: 150)
                .cornerRadius(10)
//                    .padding(.leading, 10)
                VStack(alignment: .leading, spacing: 10) {

                    HStack {
                        Text("\(NSString(format: "%.2f", fruit.itog)) р/кг")
                            .foregroundColor(Color.theme.lightGreen)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
//                        Text("\(id)")
//                            .font(.system(size: 30))
                        Spacer()
                        Button {
//                            EditButton()
//                            index = 1

                        } label: {
                            Image(systemName: "x.square")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(.black.opacity(0.6))
                        }
                    }

                    Text(fruit.name)
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                    Text(fruit.descriptions ?? "")
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(14, .uzSansRegular)))
                }
                Spacer()
            }
            HStack {
                Button {
                    if fruit.count >= 2 {
                        fruit.count -= 1
                        if fruit.price == 0 {
                            fruit.price = fruit.itog
                        } else {
                            fruit.price = fruit.itog * Double(fruit.count)
                        }

//                        viewModel.order.price -= price
//                        print("\(price)")
                        viewModel.price = fruit.price!
                        print("\(String(describing: viewModel.price))")
                    }
                } label: {
                    Image(systemName: "minus.square.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.theme.gray)
                }
                Text("\(fruit.count) кг")
                    .foregroundColor(.black)
                    .font(Font(uiFont: .fontLibrary(24, .uzSansRegular)))
                Button {
                    fruit.count += 1
                    if fruit.price == 0 {
                        fruit.price = fruit.itog
                    } else {
                        fruit.price = fruit.itog * Double(fruit.count)
                    }
//                    viewModel.order.price += price
//                    print("\(price)")
//                    viewModel.price = price
                    viewModel.price = fruit.price!
                    print("\(viewModel.price)")

                } label: {
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.theme.lightGreen)
                }
            }
            HStack {
                Text("Итого: \(NSString(format: "%.2f", fruit.price ?? 1 )) р")
                    .foregroundColor(Color.theme.lightGreen)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                    .padding(.leading, 10)
                Spacer()
            }
        }

        .onDisappear {

//                    viewModel.fruitOrder.append(fruit)

            if viewModel.fruitOrder.isEmpty {
                viewModel.fruitOrder.append(fruit)
            } else {
                viewModel.fruitOrder.removeAll()
                print("___________\(viewModel.fruitOrder.count)")

//                for i in viewModel.fruitOrder {
//                    if i.id == fruit.id {
//
////                        viewModel.fruitOrder.remove(at: i.id)
//                        print("abrakadabra")
//                    } else {
                        viewModel.fruitOrder.append(fruit)
                print("___________\(viewModel.fruitOrder.count)")
//                    }
//                }
            }
        }
        .onAppear {
            for i in fruits {

                if i.id == fruit.id {
                    fruit.count = Int(i.count)
                    fruit.price = Double(fruit.count) * fruit.itog
                    viewModel.price = fruit.price!
                    print("😇\(i.count)")
                }
            }
        }
        .padding()
        .background(.gray.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.theme.gray, lineWidth: 1)
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
            viewModel: FruitViewModel(), fruit: Fruit(cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "")
//            , imageName: "apple",
//            cost: 1,
//            name: "Apple",
//            index: "1",
//            description: "Apple 2022",
//            count: 1,
//            price: 1, id: UUID()
        )
    }
}
