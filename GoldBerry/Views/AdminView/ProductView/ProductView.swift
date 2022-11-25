import SwiftUI

struct ProductView: View {
    @ObservedObject var fruitViewModel = FruitViewModel()
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var adminViewModel = AdminViewModel()
    var body: some View {
        ZStack {
            CaseView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel,adminViewModel: adminViewModel)
            ZStack {
                VStack {
                    ZStack {
                        HStack {
                            Button {
                                //
                            } label: {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .resizable()
                                    .frame(width: 33, height: 33)
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(180))
                            }

                            Spacer()
                            Button {
                                //
                            } label: {
                                Image(systemName: "plus")
                                    .resizable()
                                    .frame(width: 33, height: 33)
                                    .foregroundColor(.white)
                            }
                        }
                        .padding(.top, 50)
                        .padding(.horizontal, 20)
                    }
                    .frame(height: 100)
                    .background(Color.green)
                    Spacer()
                    ZStack(alignment: .bottom) {
                        HStack {
                            Button {
                                fruitViewModel.selected = 0
                            } label: {
                                VStack {
                                    Image(systemName: "house")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Главная")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }
                            }.foregroundColor(fruitViewModel.selected == 0 ? Color.theme.lightGreen : Color.theme.gray)
                            Spacer(minLength: 12)

                            Button {
                                fruitViewModel.selected = 1
                            } label: {

                                VStack {
                                    Image(systemName: fruitViewModel.selected == 2 ? "bag.fill" : "bag")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Заказы")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }

                            }.foregroundColor(fruitViewModel.selected == 1 ? Color.theme.lightGreen : Color.theme.gray)
                            Spacer()

                            Button {
                                fruitViewModel.selected = 2
                            } label: {
                                VStack {
                                    Image(systemName: "speaker.wave.2.bubble.left")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Notification")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }
                            }.foregroundColor(fruitViewModel.selected == 2 ? Color.theme.lightGreen : Color.theme.gray)
                        }
                        .padding()
                        .padding(.horizontal, 22)
                        .background(Color.theme.tabBarBackground)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding()
                    .padding(.bottom, 30)
                    .shadow(color: Color.theme.lightGreen.opacity(0.5), radius: 8, x: 0, y: 5)
                }
            }
        }
        .ignoresSafeArea()
        .background(.clear)
        .onAppear {}
    }
}

struct CaseView: View {
    @ObservedObject var fruitViewModel = FruitViewModel()
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var adminViewModel: AdminViewModel
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)],
        animation: .default
    )
    var fruits: FetchedResults<FruitEntity>

    var body: some View {
        ZStack {
            switch fruitViewModel.selected {
            case 0:
                FruitView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
                    .onAppear {
                        Task {
                            do {
                                try await fruitViewModel.fetchFruit()
                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }

            case 1:
                OrderAdminView(orderViewModel: orderViewModel,adminViewModel: adminViewModel)
                    .onAppear {
                        Task {
                            do {
                                try await orderViewModel.fetchOrder()
                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }
//            case 2:
//                OrdersView(orderViewModel: orderViewModel, fruitViewModel: fruitViewModel)
//                    .onAppear {
//                        Task {
//                            do {
//                                try await orderViewModel.fetchOrder()
//                            } catch {
//                                print("❌ERORR \(error)")
//                            }
//                        }
//                    }
            default:
                FruitView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
            }
        }

        .padding(.top, 90)
        .onAppear {
            Task {
                do {
                    try await orderViewModel.fetchOrder()
                } catch {
                    print("❌ERORR \(error)")
                }
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
