import CoreData
import SwiftUI
struct CartCell: View {
    
    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var orderViewModel: OrderViewModel
    
    @State var fruit: Fruit
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
                .frame(width: 150, height: 135)
                .cornerRadius(8)
                
                VStack(alignment: .leading, spacing: 10) {
                    
                    HStack {
                        Text("\(NSString(format: "%.2f", fruit.itog)) руб/\(fruit.weightOrPieces)")
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
                        .frame(minHeight: 20, maxHeight: 40)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(14, .uzSansRegular)))
                    HStack {
                        Button {
                            if fruit.count >= 2 {
                                fruit.count -= 1
                                fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = fruit.count
                                if fruit.price == 0 {
                                    fruit.price = fruit.itog
                                } else {
                                    fruit.price = fruit.itog * fruit.count
                                    fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                                }
                            }
                            
                        } label: {
                            Image(systemName: "minus.square.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.theme.gray)
                        }
                        Text("\(Int(fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] ?? 1)) \(fruit.weightOrPieces)")
                            .foregroundColor(Color.theme.blackWhiteText)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                        Button {
                            fruit.count += 1
                            fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = fruit.count
                            if fruit.price == 0 {
                                fruit.price = fruit.itog
                            } else {
                                fruit.price = fruit.itog * fruit.count
                            }
                            fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                        } label: {
                            Image(systemName: "plus.square.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.theme.lightGreen)
                        }
                    }
                }
                Spacer()
            }
            Divider()
                .background(Color.theme.blackWhiteText)
            HStack {
                Text("Итого: ")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(16, .uzSansSemiBold)))
                    .padding(.leading, 20)
                Spacer()
                Text("\(NSString(format: "%.2f", fruit.price ?? 1)) руб")
                    .foregroundColor(Color.theme.lightGreen)
                    .font(Font(uiFont: .fontLibrary(19, .uzSansSemiBold)))
                    .padding(.trailing, 20)
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
        }
        
        .onAppear {
            
            for items in fruits {
                if items.id == fruit.id {
                    fruit.price = Double(fruit.count) * fruit.itog
                    fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                }
            }
            fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = fruit.count
            fruit.price = fruit.count * fruit.itog
        }
        .padding()
        .background(.gray.opacity(0.1))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.theme.gray, lineWidth: 1)
        )
        .cornerRadius(8)
    }
}
