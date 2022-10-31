import CoreData
import SwiftUI
struct AllProductsCell: View {
    @State var fruit: Fruit
    @ObservedObject var fruitViewModel: FruitViewModel
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>
    @FetchRequest(entity: FavoriteFruit.entity(), sortDescriptors: [])
    var favoriteFruit: FetchedResults<FavoriteFruit>
    
    @State var newCount: Int = 0
    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .bottomLeading) {
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
                    Text("-\(fruit.percent)%")
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
                                addFavoriteFruit()
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
                                        .foregroundColor(.red)
                                        .frame(width: 30, height: 30)
                                        .padding(20)
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
                        Color.theme.blackWhiteText.opacity(0.5)
                            .frame(width: 45, height: 1)
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
            .cornerRadius(10)
            .padding(.horizontal, 3)
            HStack(alignment: .top) {
                Text(fruit.comment )
                    .font(.system(size: 12, weight: .light, design: .serif))
                    .foregroundColor(Color.theme.blackWhiteText.opacity(0.8))
                Spacer()
            }
            .padding(.horizontal, 5)
            .frame(height: 60)
//            HStack {
//                Button {
//                    if fruit.count >= 2 {
//                        fruit.count  -= 1
//                        fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = fruit.count
//                        if fruit.price == 0 {
//                            fruit.price = fruit.cost
//                        } else {
//                            fruit.price = fruit.cost * Double(fruit.count)
//                        }
//                    }
//                } label: {
//                    Image(systemName: "minus.square.fill")
//                        .resizable()
//                        .frame(width: 25, height: 25)
//                        .foregroundColor(Color.theme.gray)
//                }
//                Text("\(fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] ?? 1) кг")
//                    .multilineTextAlignment(.leading)
//                    .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
//                Button {
//                    fruit.count += 1
//                    fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = fruit.count
//                    if fruit.price == 0 {
//                        fruit.price = fruit.cost
//                    } else {
//                        fruit.price = fruit.cost * Double(fruit.count)
//                    }
//
//                } label: {
//                    Image(systemName: "plus.square.fill")
//                        .resizable()
//                        .frame(width: 25, height: 25)
//                        .foregroundColor(Color.theme.lightGreen)
//                }
//                .buttonStyle(PlainButtonStyle())
//            }
//            .padding(.horizontal, 10)
            HStack {
                Button {
                    addFruit()
                    fruitViewModel.isShowCount = true
                    fruit.isValid = false
                    fruitViewModel.countCart += 1
//                    fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price

                } label: {
                    ZStack {
                        Text("В корзину")
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .light, design: .serif))
                    }
                    .frame(width: 140, height: 25)
                    .background(fruit.isValid ?? true ? Color.theme.lightGreen : Color.gray)
                    .cornerRadius(6)
                    .padding(8)
                    .shadow(color: Color.theme.blackWhiteText, radius: 2)
                }
                .disabled(!(fruit.isValid ?? true))
            }
            .padding(7)
        }
        .frame(width: 180, height: 295)
        .background(Color.theme.background)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 1, x: 0, y: 2)
        .onAppear {
            for item in fruits {
                 if item.id == fruit.id {
                    fruit.isValid = false
                }
            }
        }
    }

    func addFruit() {
        newCount = fruit.count
        fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = newCount

        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.id = fruit.id
            newFruit.counts = Int16(fruit.count)
            newFruit.name = fruit.name
            do {

                try viewContext.save()

            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
    func addFavoriteFruit() {
        withAnimation {
            let newFruit = FavoriteFruit(context: viewContext)
            newFruit.id = fruit.id
            newFruit.name = fruit.name
            newFruit.favorite = fruit.favorite
            do {
               print("🥰")
                try viewContext.save()

            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
    
}
