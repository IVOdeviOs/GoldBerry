import CoreData
import SwiftUI
struct InformationProductView: View {
    @ObservedObject var viewModel = FruitViewModel()

    @State var fruit: Fruit
    @Environment(\.presentationMode) var presentationMode
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)],
        animation: .default
    )
    private var fruits: FetchedResults<FruitEntity>

    var body: some View {

        ZStack(alignment: .top) {

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack(alignment: .top) {
                        RemoteImageView(
                            url: URL(string: fruit.image)!,
                            placeholder: {
                                Image(systemName: "icloud.and.arrow.up").frame(width: 300, height: 300)
                            },
                            image: {
                                $0
                                    .resizable()
                                    .frame(width: UIScreen.main.bounds.width - 20, height: 330)
                                    .aspectRatio(contentMode: .fit)
                            }
                        )
//                        .aspectRatio(contentMode: .fill)
//                        .frame(width: UIScreen.main.bounds.width - 20 ,height:350)
                    }
                    .cornerRadius(30)
                    .padding(3)
                    .padding(.top, 16)
//                    Spacer()
//                    HStack {
//                        Image(systemName: "car")
//                            .resizable()
//                            .frame(width: 35, height: 35)
//                            .foregroundColor(.green)
//                        Text("Бесплатная доставка от 1000 ₽")
//                            .font(.system(size: 16, weight: .medium, design: .default))
//                        Spacer()
//                    }
//                    .padding(13)
//                    .background(.gray.opacity(0.3))
//                    .cornerRadius(20)
//                    .padding(.horizontal)
                    HStack {
                      
                        if fruit.itog == fruit.cost {
                            Text("\(fruit.cost, specifier: "%.2f")₽")
                                .font(.system(size: 23, weight: .bold, design: .default))
                                .foregroundColor(.black)
                            Spacer()
                        } else {
                            Text("\(fruit.itog, specifier: "%.2f")₽")
                                .font(.system(size: 23, weight: .bold, design: .default))
                                .foregroundColor(.red)
                            ZStack {
                                Text("\(fruit.cost, specifier: "%.2f")₽")
                                    .font(.system(size: 13, weight: .light, design: .serif))
                                    .foregroundColor(.black.opacity(0.6))
                                Color(CGColor(gray: 0, alpha: 1)).opacity(0.5)
                                    .frame(width: 45, height: 0.5)
                            }

                            Spacer()
                        }
                    }
                    .padding(.horizontal)

                    HStack {
                        Text(fruit.comment ?? "Nooo")
                            .font(.system(size: 14, weight: .medium, design: .default))
                        Spacer()
                    }

                    .frame(minHeight: 70, maxHeight: 130)
                    .padding(.horizontal)

//                    .padding(.vertical,2)
                }
                .offset(y: -35)
                .navigationBarHidden(true)
            }

            ZStack {
                VStack {
                    HStack {
                        Button {
                            dismiss()

                        } label: {
                            Image(systemName: "arrow.backward.square")
                                .renderingMode(.original)
                                .scaleEffect(3)
                                .foregroundColor(Color.theme.lightGreen)
                                .frame(width: 60, height: 60)
                                .background(.white.opacity(0.3))
                                .cornerRadius(10)
                        }
                        Spacer()
                        Button {
                            fruit.favorite.toggle()
                        } label: {
                            Image(systemName: fruit.favorite ? "heart.fill" : "heart")
                                .renderingMode(.template)
                                .scaleEffect(3)
                                .foregroundColor(.red)
                                .frame(width: 60, height: 60)
                                .animation(.easeInOut(duration: 1.5))
                                .background(.white.opacity(0.3))
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    Spacer()
                    VStack {
                        Button {
                            addFruit()
                            let fruits = Fruit(cost: fruit.cost,
                                               weightOrPieces: fruit.weightOrPieces,
                                               categories: fruit.categories,
                                               favorite: fruit.favorite,
                                               count: fruit.count,
                                               image: fruit.image, name: fruit.name, percent: fruit.percent, descriptions: fruit.descriptions, price: fruit.price)

                            viewModel.fruit.append(fruits)
                            print("🥶")
                            print("\(fruits.name)")
                            print("\(fruits.image)")

                        } label: {
                            HStack {
                                Text("В корзину")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold, design: .serif))
                                Spacer()
                                Text("\(fruit.itog, specifier: "%.2f")₽")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold, design: .serif))
                            }
                            .padding()
                            .background(Color.theme.lightGreen)
                            .cornerRadius(20)
                            .padding(.horizontal, 16)
                        }
                    }
                    .offset(y: -110)
                }
            }
        }
    }

    private func addFruit() {
        withAnimation {
            let newFruit = FruitEntity(context: viewContext)
            newFruit.name = fruit.name
            newFruit.image = fruit.image
            newFruit.cost = fruit.cost
            newFruit.percent = Int16(fruit.percent ?? 0)
            newFruit.price = fruit.price ?? 1
            newFruit.favorite = fruit.favorite
            newFruit.categories = fruit.categories
            newFruit.weightOrPieces = fruit.weightOrPieces
            newFruit.count = Int16(fruit.count)
            newFruit.descriptions = fruit.descriptions
            newFruit.comment = fruit.comment
            newFruit.itog = fruit.itog
            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { fruits[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct InformationProductView_Previews: PreviewProvider {
    static var previews: some View {
        InformationProductView(fruit: Fruit(cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1, descriptions: "", price: 1))
    }
}
