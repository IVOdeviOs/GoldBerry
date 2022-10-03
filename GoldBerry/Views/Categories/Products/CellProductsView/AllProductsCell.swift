import SwiftUI

struct AllProductsCell: View {
    @State var fruit: Fruit
//    @ObservedObject var viewModel = FruitViewModel()
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .bottomLeading) {
    //                    .padding(.horizontal)
                
                RemoteImageView(
                    url: URL(string: fruit.image)!,
                    placeholder: {
                        Image(systemName: "icloud.and.arrow.up").frame(width: 300, height: 300)
                    },
                    image: {
                        $0
                            .resizable()
                            .frame(width: 180, height: 120)
                            .aspectRatio(contentMode: .fit)
                    }
                )
                if fruit.percent != 0 {
                    Text("-\(fruit.percent!)%")
                        .font(.system(size: 12, weight: .light, design: .serif))
                        .foregroundColor(.white)
                        .frame(width: 35, height: 20)
                        .padding(.horizontal, 5)
                        .background(.red)
                        .cornerRadius(20)
                        .padding(5)
                }
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                fruit.favorite.toggle()
                            } label: {
                                Image(systemName: fruit.favorite ? "heart.fill" : "heart")
                                    .resizable()
                                    .renderingMode(.template)
//                                    .scaleEffect(3)
                                    .foregroundColor(.red)
                                    .frame(width: 30, height: 30)
                                    .padding(5)
                                    .animation(.easeInOut(duration: 1.5))
                                    .background(.white.opacity(0.3))
                                    .cornerRadius(10)
                            }.frame(width: 30 ,height: 30)
                        }
                        .padding(7)
                        Spacer()
                    }
                }

            }
            HStack {
                if fruit.itog == fruit.cost {
                    Text("\(fruit.cost, specifier: "%.2f")₽")
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .foregroundColor(.black)
                    Spacer()
                } else {
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
                }
            }.padding(.horizontal, 5)

            HStack {
                Text(fruit.name)
                    .font(.system(size: 20, weight: .light, design: .serif))
                    .foregroundColor(.black)

                Spacer()
            }
            .padding(3)
//            .background(.gray.opacity(0.05))
            .cornerRadius(10)
            .padding(.horizontal,3)
            
            HStack(alignment: .firstTextBaseline) {
                Text(fruit.comment ?? "no")
                    .frame(width: 170, height: 60)
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .foregroundColor(.black.opacity(0.8))
                    .multilineTextAlignment(.leading)
            }

            HStack {
                Button {
                    if fruit.count >= 2 {
                        fruit.count -= 1
                        if fruit.price == 0 {
                            fruit.price = fruit.cost
                        } else {
                            fruit.price = fruit.cost * Double(fruit.count)
                        }

                        //                        viewModel.order.price -= price
                        //                        print("\(price)")
//                        fruit.price = fruit.price
//                        print("\(String(describing: fruit.price))")
                    }
                } label: {
                    Image(systemName: "minus.square.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.theme.gray)
                }
                Text("\(fruit.count) кг")
                    .foregroundColor(.black)
                    .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                Button {
                    fruit.count += 1
                    if fruit.price == 0 {
                        fruit.price = fruit.cost
                    } else {
                        fruit.price = fruit.cost * Double(fruit.count)
                    }
                    //                    viewModel.order.price += price
                    //                    print("\(price)")
//                    fruit.price = fruit.price
//                    print("\(fruit.price)")

                } label: {
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.theme.lightGreen)
                }
            }
            .padding(.horizontal, 10)
            HStack {
//                Spacer()
                
                Button {
                    addFruit()

                } label: {
                    HStack {
                        Text("В корзину")
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .light, design: .serif))
                        //                        Spacer()
                        //                        Text("\(itog, specifier: "%.2f")₽")
                        //                            .foregroundColor(.white)
                        //                            .font(.system(size: 18, weight: .bold, design: .serif))
                    }
                    .frame(width: 140)
                    .padding(8)
                    .background(Color.theme.lightGreen)
                    .cornerRadius(10)
                    .shadow(color: .black, radius: 2)
                    //                    .padding(.horizontal, 16)
                }
            }
            .padding(7)
            
        }
        .frame(width: 180, height: 320)
        .background(.white)
        .cornerRadius(20)
        .shadow(color: .gray, radius: 1, x: 0, y: 2)
    }

    func addFruit() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.id = fruit.id
            newFruit.count = Int16(fruit.count)

            for i in fruits{
                if newFruit.id == i.id {
                    viewContext.delete(newFruit)
                }
            }
//            newFruit.name = fruit.name
//            newFruit.image = fruit.image
//            newFruit.cost = fruit.cost
//            newFruit.percent = Int16(fruit.percent ?? 1)
//            newFruit.price = fruit.price ?? 0
//            newFruit.favorite = fruit.favorite
//            newFruit.categories = fruit.categories
//            newFruit.weightOrPieces = fruit.weightOrPieces
//            newFruit.count = Int16(fruit.count)
//            newFruit.descriptions = fruit.descriptions
//            newFruit.comment = fruit.comment
//            newFruit.itog = Double(fruit.itog)
//            print(newFruit.name! + "😍")
            do {
              
                try viewContext.save()
                
                
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct AllProductsCell_Previews: PreviewProvider {
    static var previews: some View {
        AllProductsCell(fruit: Fruit(cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1, descriptions: "", price: 1)).previewLayout(.fixed(width: 180, height: 290))
    }
}

