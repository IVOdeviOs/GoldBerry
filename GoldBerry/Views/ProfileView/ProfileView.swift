import CoreData
import FirebaseAuth
import FirebaseCore
import SwiftUI

struct ProfileView: View {
    @ObservedObject var fruitViewModel = FruitViewModel()
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var userViewModel = UserViewModel()

    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.id, ascending: true)])
    var fruits: FetchedResults<FruitEntity>

    let email = UserDefaults.standard.value(forKey: "userEmail")
    let user = Auth.auth().currentUser
    func orderCount() -> Int {
        var ordersCount = 0
        for item in orderViewModel.order {
            if item.email == email as? String ?? "asda" {
                ordersCount += 1
            }
        }
        return ordersCount
    }

    func deleteAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "FruitEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try viewContext.execute(deleteRequest)

            try viewContext.save()
        } catch {
            print("There was an error")
        }
    }

    var body: some View {
        Color.theme.background
            .ignoresSafeArea()
            .overlay(
                VStack {
                    ZStack {
                        Color.theme.lightGreen
                            .frame(height: 240)
                            .offset(y: -50)
                        HStack {
                            VStack {
                                Text(userViewModel.userName.isEmpty && userViewModel.userSurname.isEmpty ? "Имя Фамилия" : "\(userViewModel.userName) \(userViewModel.userSurname)")
                                    .foregroundColor(Color.theme.background)
                                    .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                                    .padding()
                            }
                            Spacer()
                            Button {
                                userViewModel.showUserInfoView.toggle()
                            } label: {
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 30, height: 30)
                                    .foregroundColor(Color.theme.background)
                                    .padding(.trailing, 20)
                            }
                            .sheet(isPresented: $userViewModel.showUserInfoView, content: {
                                UserInfoView(userViewModel: userViewModel)
                            })
                        }
                    }
                    ZStack {
                        Button {
                            fruitViewModel.selected = 2
                        } label: {
                            ZStack {
                                Color.theme.tabBarBackground
                                    .frame(width: 120, height: 70)
                                    .cornerRadius(10)
                                    .shadow(color: .gray, radius: 2, x: 1, y: 1)
                                VStack {
                                    Text("Архив заказов")
                                        .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                                        .foregroundColor(Color.theme.blackWhiteText)
                                        .padding(.bottom, 5)
                                    Text("\(orderCount())")
                                        .font(Font(uiFont: .fontLibrary(24, .uzSansSemiBold)))
                                        .foregroundColor(Color.theme.blackWhiteText)
                                }
                            }
                        }
                        .offset(x: -110, y: -80)
                    }
                    Button {
                        userViewModel.showShopView.toggle()
                    } label: {
                        ZStack {
                            Color.theme.grayWhite
                                .frame(height: 50)
                            HStack {
                                Text("Адреса торговых точек")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                                    .padding(.leading, 15)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .padding(.trailing, 20)
                            }
                            .sheet(isPresented: $userViewModel.showShopView, content: {
                                ShopsView(fruitViewModel: fruitViewModel)
                            })
                        }
                    }
                    Button {
                        userViewModel.showFavouriteProductsView.toggle()
                    } label: {
                        ZStack {
                            Color.theme.grayWhite
                                .frame(height: 50)
                            HStack {
                                Text("Избранные товары")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                                    .padding(.leading, 15)
                                Spacer()
                                ZStack {
                                    if !userViewModel.favouriteProducts.isEmpty {
                                        Color.red
                                            .frame(width: 20, height: 20)
                                            .cornerRadius(10)
                                        Text("\(userViewModel.favouriteProducts.count)")
                                            .minimumScaleFactor(0.5)
                                            .foregroundColor(.white)
                                            .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                    }
                                }
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .padding(.trailing, 20)
                            }
                            .sheet(isPresented: $userViewModel.showFavouriteProductsView, content: {
                                FavouriteProductsView(fruitViewModel: fruitViewModel)
                            })
                        }
                    }
                    NavigationLink {
                        ServiceInfoView()
                    } label: {
                        ZStack {
                            Color.theme.grayWhite
                                .frame(height: 50)
                            HStack {
                                Text("О сервисе")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                                    .padding(.leading, 15)
                                Spacer()

                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .padding(.trailing, 20)
                            }
                        }
                    }
                    ZStack {
                        Button {
                            let formattedString = "tel://" + userViewModel.numberPhone
                            guard let url = URL(string: formattedString) else { return }
                            UIApplication.shared.open(url)
                        } label: {
                            ZStack {
                                Color.theme.grayWhite
                                    .frame(height: 50)
                                HStack {
                                    Text("Служба поддержки")
                                        .foregroundColor(Color.theme.blackWhiteText)
                                        .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                                        .padding(.leading, 15)
                                    Spacer()
                                    Image(systemName: "arrow.right")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(Color.theme.blackWhiteText)
                                        .padding(.trailing, 20)
                                }
                            }
                        }
                    }
                    Spacer()
                    HStack {
                        Button {
                            userViewModel.alert = true

                        } label: {
                            HStack(spacing: 5) {
                                Image(systemName: "rectangle.portrait.and.arrow.right")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(Color.theme.blackWhiteText)
                                Text("Выход")
                                    .font(Font(uiFont: .fontLibrary(14, .uzSansSemiBold)))
                                    .foregroundColor(Color.theme.blackWhiteText)
                            }
                        }
                        .alert(isPresented: $userViewModel.alert) {
                            Alert(title: Text("Выйти"),
                                  message: Text("Вы точно хотите выйти из аккаунта ?"),
                                  primaryButton: .destructive(Text("Да")) {
                                      UserDefaults.standard.set(false, forKey: "status")
                                      NotificationCenter.default.post(name: NSNotification.Name("statusChange"),
                                                                      object: nil)
                                      deleteAllRecords()

                                      UserDefaults.standard.removeObject(forKey: userViewModel.nameKey)
                                      UserDefaults.standard.removeObject(forKey: userViewModel.surNameKey)
                                      UserDefaults.standard.removeObject(forKey: userViewModel.numberPhoneKey)
                                  },
                                  secondaryButton: .cancel())
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .padding(.leading, 10)
                        Spacer()
                        Button {
                            userViewModel.alertDeleted = true
                        } label: {
                            HStack(spacing: 5) {
                                Image(systemName: "x.square")
                                    .resizable()
                                    .frame(width: 14, height: 14)
                                    .foregroundColor(Color.red)
                                Text("Удалить аккаунт")
                                    .font(Font(uiFont: .fontLibrary(14, .uzSansSemiBold)))
                                    .foregroundColor(Color.red)
                            }
                        }
                        .alert(isPresented: $userViewModel.alertDeleted) {
                            Alert(title: Text("Удалить аккаунт"),
                                  message: Text("Вы точно хотите удалить свой аккаунт?"),
                                  primaryButton: .destructive(Text("Да")) {
                                      do {
                                          try Auth.auth().signOut()
                                          UserDefaults.standard.set(false, forKey: "status")
                                          NotificationCenter.default.post(name: NSNotification.Name("statusChange"),
                                                                          object: nil)
                                          deleteAllRecords()
                                          UserDefaults.standard.removeObject(forKey: userViewModel.nameKey)
                                          UserDefaults.standard.removeObject(forKey: userViewModel.surNameKey)
                                          UserDefaults.standard.removeObject(forKey: userViewModel.numberPhoneKey)
                                      } catch {}

                                  },
                                  secondaryButton: .cancel())
                        }
                        .padding(.vertical, 10)
                        .padding(.horizontal)
                        .padding(.leading, 10)
                    }
                    .offset(y: -90)
                    .navigationBarHidden(true)
                }
                .background(Color.theme.background)
            )
            .offset(y: -40).background(Color.theme.background)
            .ignoresSafeArea()
            .onAppear {
                let name = UserDefaults.standard.value(forKey: userViewModel.nameKey)
                let surName = UserDefaults.standard.value(forKey: userViewModel.surNameKey)
                let phone = UserDefaults.standard.value(forKey: userViewModel.numberPhoneKey)

                userViewModel.userName = name as? String ?? ""
                userViewModel.userSurname = surName as? String ?? ""
                userViewModel.userPhone = phone as? String ?? ""
            }
    }
}
