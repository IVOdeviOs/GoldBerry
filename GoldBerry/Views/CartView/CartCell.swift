import CoreData
import SwiftUI
struct CartCell: View {

    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var orderViewModel: OrderViewModel
   
    @State var fruit: Fruit
    @State var testCount: Int = 1
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.id, ascending: true)])
    var fruits: FetchedResults<FruitEntity>

    func removeCell(fru: Fruit) {
        for item in fruits {
            if fru.id == item.id {
                viewContext.delete(item)
                fruitViewModel.uniqFruits.removeFirst()
                fruitViewModel.countCart -= 1
                fruitViewModel.arrayOfFruitPrice.removeValue(forKey: item.name ?? "")
                do {
                    try viewContext.save()
                } catch {}
            }
        }
    }


    
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
                }
                .frame(width: 150, height: 110)
                .cornerRadius(10)
                VStack(alignment: .leading, spacing: 10) {

                    HStack {
                        Text("\(NSString(format: "%.2f", fruit.itog)) р/кг")
                            .foregroundColor(Color.theme.lightGreen)
                            .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                        Spacer()
                        Button {
                            withAnimation(.linear(duration: 0.5)) {
                                removeCell(fru: fruit)
                            }
                           
                        } label: {
                            Image(systemName: "x.square")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color.theme.blackWhiteText)
                        }
                    }

                    Text(fruit.name)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                    Text(fruit.comment)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(14, .uzSansRegular)))
                    Spacer()
                }
                Spacer()
            }
            HStack {
                Button {
                    if fruit.count >= 2 {
                        fruit.count -= 1
                        fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name]! -= 1
                        if fruit.price == 0 {
                            fruit.price = fruit.itog
                        } else {
                            fruit.price = fruit.itog * Double(fruit.count)
                            fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                        }
                    }
                    
                } label: {
                    Image(systemName: "minus.square.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.theme.gray)
                }
                Text("\(fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] ?? 1) кг")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                Button {
                    fruit.count += 1
                    fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name]! += 1
                    if fruit.price == 0 {
                        fruit.price = fruit.itog
                    } else {
                        fruit.price = fruit.itog * Double(fruit.count)
                    }
                    fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                } label: {
                    Image(systemName: "plus.square.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.theme.lightGreen)
                }
            }
            HStack {
                Spacer()
                Text("Итого: \(NSString(format: "%.2f", fruit.price ?? 1)) р")
                    .foregroundColor(Color.theme.lightGreen)
                    .font(Font(uiFont: .fontLibrary(16, .uzSansSemiBold)))
                    .padding(.trailing, 10)
            }
        }

        .onDisappear {
            for item in fruits {
                if item.id == fruit.id {
                    fruitViewModel.uniqFruits.removeFirst()
                    fruitViewModel.uniqFruits.append(fruit)
                    fruit.price = Double(fruit.count) * fruit.itog
                    fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                }
            }
            fruit.count = fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] ?? 1
        }

        .onAppear {
            for items in fruits {

                if items.id == fruit.id {
                    fruit.price = Double(fruit.count) * fruit.itog

                    fruit.price = Double(items.counts) * fruit.itog
                    fruit.count = Int(items.counts)
                    fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = fruit.count
                    fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                }
            }
        }
        .padding()
        .background(.gray.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.theme.gray, lineWidth: 1)
        )
        .cornerRadius(12)
    }
}
