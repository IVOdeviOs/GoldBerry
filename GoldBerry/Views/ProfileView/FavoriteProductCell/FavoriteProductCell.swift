import SwiftUI
import CoreData

struct FavoriteProductCell: View {
    @ObservedObject var fruitViewModel: FruitViewModel
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FavoriteFruit.entity(), sortDescriptors: [])
    var favoriteFruit: FetchedResults<FavoriteFruit>
    
    @State var fruit: Fruit
    @State var favorite = true
    @State var newCount: Double = 0
    func removeCell(fru: Fruit) {
        for item in favoriteFruit {
            if fru.id == item.id {
                
                fruitViewModel.favoriteFruits.removeFirst()
                viewContext.delete(item)
                

                do {
                    try viewContext.save()
                } catch {}
            }
        }
    }

    var body: some View {
        VStack(spacing: 6) {
            ZStack(alignment: .bottomLeading) {
                AsyncImage(
                    url: URL(string: fruit.image),
                    transaction: Transaction(animation: .easeInOut)
                ) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image
                            .resizable()
                            .transition(.scale(scale: 0.1, anchor: .center))
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
                ZStack {
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                favorite.toggle()
                                withAnimation(.linear(duration: 0.5)) {
                                    removeCell(fru: fruit)
                                }
                               
                            } label: {
                                ZStack {
                                    Image(systemName: "heart.fill")
                                        .resizable()
                                        .frame(width: 35, height: 35)
                                        .foregroundColor(.white.opacity(0.5))
                                        .padding(20)

                                    Image(systemName: favorite ? "heart.fill" : "heart")
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
                    Text("\(fruit.cost, specifier: "%.2f") руб")
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(Color.theme.blackWhiteText)
                    Spacer()
                } else {
                    Text("\(fruit.itog, specifier: "%.2f") руб")
                        .font(.system(size: 14, weight: .bold, design: .serif))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(.red)
                    ZStack {
                        Text("\(fruit.cost, specifier: "%.2f") руб")
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
                Button {
                    addFruit()
                    fruit.count = 1
                    fruitViewModel.isShowCount = true
                    fruit.isValid = false
                    fruitViewModel.countCart += 1
                } label: {
                    ZStack {
                        Text("Add to cart")
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
        } .onDisappear {
            for item in favoriteFruit {
                if item.id == fruit.id {
                    fruitViewModel.favoriteFruits.removeFirst()
                    fruitViewModel.favoriteFruits.append(fruit)
                }
            }
        }
        .frame(width: 180, height: 295)
        .background(Color.theme.background)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 1, x: 0, y: 2)
    }

    func addFruit() {
        newCount = Double(fruit.count)
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

}
