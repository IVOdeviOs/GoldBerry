import SwiftUI

struct ProductViewCell: View {
    @State var fruit: Fruit
    @ObservedObject var adminViewModel: AdminViewModel
    
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
                                adminViewModel.deleteFruit.toggle()

                            } label: {

                                Image(systemName: "xmark.app")
                                    .resizable()
                                    .renderingMode(.template)
                                    .foregroundColor(.red)
                                    .frame(width: 30, height: 30)
                                    .padding(20)

                            }.frame(width: 35, height: 45)
                                .alert(isPresented: $adminViewModel.deleteFruit) {
                                    Alert(title: Text("Удалить"),
                                          message: Text("Вы точно хотите удалить фрукт ?"),
                                          primaryButton: .destructive(Text("Да")) {
                                              Task {
                                                  do {
                                                      try await adminViewModel.deleteFruit(id: fruit.id)
                                                      adminViewModel.selected = 1
                                                      DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                                                          self.adminViewModel.selected = 0
                                                      }
                                                  } catch {}
                                              }

                                          },
                                          secondaryButton: .cancel())
                                }
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
//                    addFruit()
//                    fruit.count = 1
//                    fruitViewModel.isShowCount = true
//                    fruit.isValid = false
//                    fruitViewModel.countCart += 1
                    ////                    fruitViewModel.arrayOfFruitPrice[fruit.name] = fruit.price
                    self.adminViewModel.showUpdate.toggle()
                } label: {
                    ZStack {
                        Text("Редактировать")
                            .foregroundColor(.white)
                            .font(.system(size: 12, weight: .light, design: .serif))
                    }
                    .frame(width: 140, height: 25)
                    .background(Color.theme.lightGreen)
                    .cornerRadius(6)
                    .padding(8)
                    .shadow(color: Color.theme.blackWhiteText, radius: 2)
                }
            }
            .padding(7)
            .fullScreenCover(isPresented: $adminViewModel.showUpdate) {
                AddFruit(adminViewModel: adminViewModel,
                         productName: fruit.name,
                         productDescription: fruit.comment,
                         productPrice: String(fruit.cost),
                         productDiscount: String(fruit.percent),
                         productCategories: fruit.categories)
            }
        }
       
        .frame(width: 180, height: 295)
        .background(Color.theme.background)
        .cornerRadius(10)
        .shadow(color: .gray, radius: 1, x: 0, y: 2)
    }
}

//
//var fruitId: UUID?
//var isUpdating: Bool {
//    fruitId != nil
//}
//
//func addUpdateAction(completion: @escaping () -> Void) {
//    Task {
//        do {
//            if isUpdating {
//                try await updateFruit(id: <#T##UUID#>, cost: <#T##Double#>, weightOrPieces: <#T##String#>, categories: <#T##String#>, favorite: <#T##Bool#>, count: <#T##Double#>, image: <#T##String#>, name: <#T##String#>, percent: <#T##Int#>, price: <#T##Double?#>, comment: <#T##String#>, stepCount: <#T##Double#>, isValid: <#T##Bool?#>)
//            } else {
//
//                try await addFruit(fruits: fruit)
//            }
//        } catch {
//
//            print("🤣")
//        }
//        completion()
//    }
//}
