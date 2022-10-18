import SwiftUI
import CoreData
struct AllProductsCell: View {
    @State var fruit: Fruit
    @ObservedObject var fruitViewModel: FruitViewModel
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
                                ZStack {
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(.white.opacity(0.5))
                                        .padding(20)
                                
                                Image(systemName: fruit.favorite ? "heart.fill" : "heart")
                                    .resizable()
                                    .renderingMode(.template)
//                                    .scaleEffect(3)
                                    .foregroundColor(.red)
                                    .frame(width: 30, height: 30)
                                    .padding(20)
//                                    .animation(.easeInOut(duration: 1.5))
//                                    .background(.white.opacity(0.5))
//                                    .cornerRadius(10)
                                }
                            }.frame(width: 35, height: 45)
                           
                        }
                        .padding(10)
                        Spacer()
                    }
                }
            }
            HStack {
                if fruit.itog == fruit.cost {
                    Text("\(fruit.cost, specifier: "%.2f")₽")
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.theme.blackWhiteText)
                    Spacer()
                } else {
                    Text("\(fruit.itog, specifier: "%.2f")₽")
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.red)
                    ZStack {
                        Text("\(fruit.cost, specifier: "%.2f")₽")
                            .font(.system(size: 12, weight: .light, design: .serif))
                            .foregroundColor(Color.theme.blackWhiteText.opacity(0.6))
                            .multilineTextAlignment(.leading)
                        Color(CGColor(gray: 0, alpha: 1)).opacity(0.5)
                            .frame(width: 45, height: 0.5)
                    }

                    Spacer()
                }
            }.padding(.horizontal, 5)

            HStack {
                Text(fruit.name)
                    .font(.system(size: 20, weight: .light, design: .serif))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            .padding(3)
//            .background(.gray.opacity(0.05))
            .cornerRadius(10)
            .padding(.horizontal, 3)
            HStack(alignment: .top) {
                Text(fruit.comment ?? "no")
//                    .frame(width: 170, height: 60)
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .foregroundColor(Color.theme.blackWhiteText.opacity(0.8))
//                    .multilineTextAlignment(.leading)
                Spacer()
              
            }
            .padding(.horizontal,5)
            .frame(height: 60)
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
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.theme.gray)
                }
                Text("\(fruit.count) кг")
                    .multilineTextAlignment(.leading)
                    .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                Button {
                    fruit.count += 1
                    if fruit.price == 0 {
                        fruit.price = fruit.cost
                    } else {
                        fruit.price = fruit.cost * Double(fruit.count)
                    }


                } label: {
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.theme.lightGreen)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal, 10)
            HStack {
//                Spacer()

                Button {
                    addFruit()
                    fruitViewModel.isShowCount = true
                    fruit.isValid = false
                    fruitViewModel.countCart += 1
                    fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                } label: {
                    ZStack {
                        Text("В корзину")
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .light, design: .serif))
                    }
                    .frame(width: 140,height: 25)
                    .background(fruit.isValid ?? true ? Color.theme.lightGreen : Color.gray)
                    .cornerRadius(6)
                    .padding(8)
                    .shadow(color: Color.theme.blackWhiteText, radius: 2)
                }
                .disabled(!(fruit.isValid ?? true))
            }
            .padding(7)
        }
        .frame(width: 180, height: 320)
        .background(Color.theme.background)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 1, x: 0, y: 2)
        .onAppear {
            for i in fruits {
                if i.id == fruit.id {
                    fruit.isValid = false
                }
            }
        }
    }

    func addFruit() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.id = fruit.id
            newFruit.counts = Int16(fruit.count)
//            print("\(newFruit.counts)___________")
//            for i in fruits {
//
//                if newFruit.id == i.id {
//                    viewContext.delete(newFruit)
//                }
//            }

            do {

                try viewContext.save()

            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
