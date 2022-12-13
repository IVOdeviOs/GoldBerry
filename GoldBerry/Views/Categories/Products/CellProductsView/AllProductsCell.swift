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
    @State var favorite = false
    @State var newCount: Double = 0
    func removeCell(fru: Fruit) {
        for item in favoriteFruit {
            if fru.id == item.id {
                viewContext.delete(item)
                do {
                    try viewContext.save()
                } catch {}
            }
        }
    }
    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

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
                            .frame(width: 180, height: 120)
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
                                if status {
                                    addFavoriteFruit()
                                    for item in favoriteFruit {
                                        if item.id == fruit.id, favorite == true {
                                            removeCell(fru: fruit)
                                        }
                                    }
                                    favorite.toggle()
                                } else {
                                    fruitViewModel.alertFavorite.toggle()
                                    
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
            for asd in favoriteFruit {
                if asd.favorite == true {
                    if asd.id == fruit.id {
                        favorite = true
                    }
                }
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"),
                                                   object: nil,
                                                   queue: .main)
            { _ in
                let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                self.status = status
            }
        }
    }

    func addFruit() {
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
            newFruit.favorite = true
            do {
                try viewContext.save()

            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}
