import SwiftUI

struct ProductView: View {
    @ObservedObject var adminViewModel = AdminViewModel()
    @ObservedObject var fruitViewModel = FruitViewModel()
    @Environment(\.presentationMode) var presentation
    var body: some View {
        ZStack {
            CaseView(adminViewModel: adminViewModel)
            ZStack {
                VStack {
                    ZStack {
                        HStack {
                            Button {
                                adminViewModel.statusAdmin = false
                                self.presentation.wrappedValue.dismiss()
                                
                            } label: {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .resizable()
                                    .frame(width: 33, height: 33)
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(180))
                            }
                            
                            Spacer()
                            Button {
                                adminViewModel.showAddFruit.toggle()
                                adminViewModel.isUpdating = false
                                
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
                    .background(Color.theme.lightGreen)
                
                    Spacer()
                    ZStack(alignment: .bottom) {
                        HStack {
                            Button {
                                adminViewModel.selected = 0
                            } label: {
                                VStack {
                                    Image(systemName: "house")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Главная")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }
                            }.foregroundColor(adminViewModel.selected == 0 ? Color.theme.lightGreen : Color.theme.gray)
                            Spacer(minLength: 12)

                            Button {
                                adminViewModel.selected = 1
                            } label: {

                                VStack {
                                    Image(systemName: adminViewModel.selected == 2 ? "bag.fill" : "bag")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Заказы")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }

                            }.foregroundColor(adminViewModel.selected == 1 ? Color.theme.lightGreen : Color.theme.gray)
                            Spacer()

                            Button {
                                adminViewModel.selected = 2
                            } label: {
                                VStack {
                                    Image(systemName: "speaker.wave.2.bubble.left")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                    Text("Notification")
                                        .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                }
                            }.foregroundColor(adminViewModel.selected == 2 ? Color.theme.lightGreen : Color.theme.gray)
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
        .fullScreenCover(isPresented: $adminViewModel.showAddFruit) {
            AddFruit(adminViewModel: adminViewModel)
        }
        .ignoresSafeArea()
        .background(.clear)
    }
}

struct CaseView: View {
    @ObservedObject var adminViewModel: AdminViewModel
    var body: some View {
        ZStack {
            switch adminViewModel.selected {
            case 0:
                FruitView(adminViewModel: adminViewModel)
                    .onAppear {
                        Task {
                            do {
                                try await adminViewModel.fetchFruit()
                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }

            case 1:
                OrderAdminView(adminViewModel: adminViewModel)
                    .onAppear {
                        Task {
                            do {
                                try await adminViewModel.fetchOrder()
                            } catch {
                                print("❌ERORR \(error)")
                            }
                        }
                    }
            case 2:
               NotificationView()
            default:
                FruitView(adminViewModel: adminViewModel)
            }
        }

        .padding(.top, 90)
        .onAppear {
            Task {
                do {
                    try await adminViewModel.fetchFruit()
                    try await adminViewModel.fetchOrder()
                } catch {
                    print("❌ERORR \(error)")
                }
            }
        }
    }
}
