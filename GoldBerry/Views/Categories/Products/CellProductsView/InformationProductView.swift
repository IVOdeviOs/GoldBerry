import CoreData
import SwiftUI
struct InformationProductView: View {
    @ObservedObject var viewModel = FruitViewModel()
//
//    @State var fruit: Fruit
    @Environment(\.presentationMode) var presentationMode
    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
//
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    private var fruits: FetchedResults<FruitEntity>
    
    @State var image:String
    @State var name:String
    @State var itog:Double
    @State var cost:Double
    @State var comment:String
    @State var favorite:Bool
    @State var count:Int
    @State var percent:Int
    @State var weightOrPieces :String
    @State var descriptions :String
    @State var price:Double
    @State var categories:String

    
    
    var body: some View {

        ZStack(alignment: .top) {

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack(alignment: .top) {
                        RemoteImageView(
                            url: URL(string: image)!,
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
                    Spacer()
                    HStack {
                        Text(name)
                            .font(.system(size: 16, weight: .medium, design: .default))
                        Spacer()
                    }
                    .padding(13)
                    .background(.gray.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    HStack {

                        if itog == cost {
                            Text("\(cost, specifier: "%.2f")₽")
                                .font(.system(size: 23, weight: .bold, design: .default))
                                .foregroundColor(.black)
                            Spacer()
                        } else {
                            Text("\(itog, specifier: "%.2f")₽")
                                .font(.system(size: 23, weight: .bold, design: .default))
                                .foregroundColor(.red)
                            ZStack {
                                Text("\(cost, specifier: "%.2f")₽")
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
                        Text(comment )
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
                            favorite.toggle()
                        } label: {
                            Image(systemName: favorite ? "heart.fill" : "heart")
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
//                            let frui = Fruit(cost: Double(cost),
//                                             weightOrPieces: weightOrPieces,
//                                             categories: categories,
//                                             favorite: favorite,
//                                             count: count,
//                                             image: image,
//                                             name: name,
//                                             percent: percent,
//                                             descriptions: descriptions,
//                                             price: price)
//
//                            viewModel.fruit.append(frui)
                            print("🥶")
                            print("\(name)")
                            print("\(image)")

                        } label: {
                            HStack {
                                Text("В корзину")
                                    .foregroundColor(.white)
                                    .font(.system(size: 18, weight: .bold, design: .serif))
                                Spacer()
                                Text("\(itog, specifier: "%.2f")₽")
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
            newFruit.name = name
            newFruit.image = image
            newFruit.cost = cost
            newFruit.percent = Int16(percent )
            newFruit.price = price
            newFruit.favorite = favorite
            newFruit.categories = categories
            newFruit.weightOrPieces = weightOrPieces
            newFruit.count = Int16(count)
            newFruit.descriptions = descriptions
            newFruit.comment = comment
            newFruit.itog = Double(itog)
//            print(newFruit. + "😍")
            
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

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { fruits[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

struct InformationProductView_Previews: PreviewProvider {
    static var previews: some View {
        InformationProductView(image: "", name: "", itog: 1, cost: 1, comment: "", favorite: true, count: 1, percent: 1, weightOrPieces: "", descriptions: "", price: 1, categories: "")
    }
}
