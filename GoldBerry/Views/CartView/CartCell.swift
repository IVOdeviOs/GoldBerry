import CoreData
import SwiftUI
struct CartCell: View {

    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var orderViewModel: OrderViewModel

    @State var fruit: Fruit

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
//                            EditButton()
//                            index = 1
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
                    Text(fruit.comment ?? "ddd")
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
                Text("\(fruit.count) кг")
                    .foregroundColor(Color.theme.blackWhiteText)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansRegular)))
                Button {
                    fruit.count += 1
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
            for i in fruits {
                if i.id == fruit.id {
                    fruitViewModel.uniqFruits.removeFirst()
                    fruitViewModel.uniqFruits.append(fruit)
                    fruit.price = Double(fruit.count) * fruit.itog
                    fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                }
            }
        }

        .onAppear {
            for i in fruits {

                if i.id == fruit.id {
                    fruit.price = Double(fruit.count) * fruit.itog

                    fruit.price = Double(i.counts) * fruit.itog
                    fruit.count = Int(i.counts)
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
