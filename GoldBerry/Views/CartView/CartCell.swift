import CoreData
import SwiftUI
struct CartCell: View {

    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var orderViewModel: OrderViewModel

    @State var buttonIsTupped = false
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
                                .frame(width: 150, height: 100)
                                .aspectRatio(contentMode: .fill)
                        case .failure:
                            Image(systemName: "wifi.slash")
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 150, height: 100)
                }
                .frame(width: 150, height: 100)
                .cornerRadius(8)
                .offset(y: -8)
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
                    if fruit.favorite {} else {
                        HStack {
                            Button {
                                if fruit.count >= fruit.stepCount * 2 {
                                    fruit.count -= fruit.stepCount
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
                            switch fruit.weightOrPieces {
                            case "шт":
                                Text("\(NSString(format: "%.0f", fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] ?? 1)) \(fruit.weightOrPieces)")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                            default:
                                Text("\(NSString(format: "%.1f", fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] ?? 1)) \(fruit.weightOrPieces)")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                            }
                            Button {
                                buttonIsTupped = true
                                fruit.count += fruit.stepCount
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
                }
                Spacer()
            }
            Divider()
                .background(Color.theme.blackWhiteText)
            if fruit.favorite {

                HStack {
                    Text("Товар отсутствует в данный момент")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(16, .uzSansSemiBold)))
//                        .padding(.leading, 20)
                }
                .padding(.horizontal)
                .padding(.vertical, 7)
                .background(Color.gray.opacity(0.5))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.theme.gray, lineWidth: 1)
                )
                .cornerRadius(8)

            } else {
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
        }
        .onDisappear {
            for item in fruits {
                if item.id == fruit.id {
                    fruitViewModel.uniqFruits.removeFirst()
                    fruitViewModel.uniqFruits.append(fruit)
                   
                    if fruit.favorite {
                        fruit.price = 0
                        fruit.count = 0
                        fruitViewModel.arrayOfFruitPrice[fruit.name] = 0
                        fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = 0
                    }else {
                        fruit.price = Double(fruit.count) * fruit.itog
                        fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                        fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = fruit.count
                    }
                }
            }
        }

        .onAppear {

            for items in fruits {
                if items.id == fruit.id {
                 
//                    fruit.price = fruit.count * fruit.itog
                    if fruit.favorite {
                        fruit.price = 0
                        fruit.count = 0
                        fruitViewModel.arrayOfFruitPrice[fruit.name] = 0
                        fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = 0
                    }else{
                        fruit.price = Double(fruit.count) * fruit.itog
                        fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                        fruitViewModel.dictionaryOfNameAndCountOfFruits[fruit.name] = fruit.count
                    }
                }
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.theme.gray, lineWidth: 1)
        )
        .cornerRadius(8)
    }
}
