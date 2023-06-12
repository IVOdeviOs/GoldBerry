import CoreData
import FirebaseAuth
import FirebaseCore
import SwiftUI

struct ProfileView: View {
    @ObservedObject var fruitViewModel = FruitViewModel()
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var userViewModel = UserViewModel()
    @ObservedObject var adminViewModel: AdminViewModel
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

    @State var status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false

    func deleteAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "FruitEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try viewContext.execute(deleteRequest)

            try viewContext.save()
        } catch {}
    }

    var body: some View {
        Color.theme.background
            .ignoresSafeArea()
            .overlay(
                VStack {
                    ZStack {
                        Color.theme.orange
                            .frame(height: 240)
                            .offset(y: -50)
                        HStack {
                            VStack {
                                Text(userViewModel.userName.isEmpty && userViewModel.userSurname.isEmpty ? "First Name Last Name" : "\(userViewModel.userName) \(userViewModel.userSurname)")
                                    .foregroundColor(Color.theme.background)
                                    .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
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
                                    Text("Order archive")
                                        .font(Font(uiFont: .fontLibrary(16, .pFBeauSansProRegular)))
                                        .foregroundColor(Color.theme.blackWhiteText)
                                        .padding(.bottom, 5)
                                    Text("\(orderCount())")
                                        .font(Font(uiFont: .fontLibrary(24, .pFBeauSansProSemiBold)))
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
                                Text("Store addresses")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                                    .padding(.leading, 15)
                                Spacer()
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .padding(.trailing, 20)
                            }
                            .sheet(isPresented: $userViewModel.showShopView, content: {
                                ShopsView(fruitViewModel: fruitViewModel, userViewModel: userViewModel)
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
                                Text("Featured Products")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
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
                                            .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
                                    }
                                }
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .padding(.trailing, 20)
                            }
                            .sheet(isPresented: $userViewModel.showFavouriteProductsView, content: {
                                FavouriteProductsView(fruitViewModel: fruitViewModel, userViewModel: userViewModel)
                            })
                        }
                    }
                    NavigationLink {
                        ServiceInfoView(adminViewModel: adminViewModel,userViewModel: userViewModel)
                    } label: {
                        ZStack {
                            Color.theme.grayWhite
                                .frame(height: 50)
                            HStack {
                                Text("About the service")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
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
                                    Text("Support service")
                                        .foregroundColor(Color.theme.blackWhiteText)
                                        .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
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
                    if status {
                        HStack {
                            Button {
                                userViewModel.alert = true

                            } label: {
                                HStack(spacing: 5) {
                                    Image(systemName: "rectangle.portrait.and.arrow.right")
                                        .resizable()
                                        .frame(width: 14, height: 14)
                                        .foregroundColor(Color.theme.blackWhiteText)
                                    Text("Output")
                                        .font(Font(uiFont: .fontLibrary(14, .pFBeauSansProSemiBold)))
                                        .foregroundColor(Color.theme.blackWhiteText)
                                }
                            }
                            .alert(isPresented: $userViewModel.alert) {
                                Alert(title: Text("Output"),
                                      message: Text("Are you sure you want to log out of your account?"),
                                      primaryButton: .destructive(Text("Yes")) {
                                          UserDefaults.standard.set(false, forKey: "status")
                                          NotificationCenter.default.post(name: NSNotification.Name("statusChange"),
                                                                          object: nil)
                                          UserDefaults.standard.removeObject(forKey: "userEmail")
                                          UserDefaults.standard.removeObject(forKey: userViewModel.nameKey)
                                          UserDefaults.standard.removeObject(forKey: userViewModel.surNameKey)
                                          UserDefaults.standard.removeObject(forKey: userViewModel.numberPhoneKey)
                                          fruitViewModel.countCart = 0
                                          fruitViewModel.isShowCount = false
                                          fruitViewModel.showCartCount = false
                                          DispatchQueue.main.async {
                                              fruitViewModel.arrayOfFruitPrice.removeAll()
                                              deleteAllRecords()
                                              fruitViewModel.uniqFruits.removeAll()
                                          }
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
                                    Text("Delete account")
                                        .font(Font(uiFont: .fontLibrary(14, .pFBeauSansProSemiBold)))
                                        .foregroundColor(Color.red)
                                }
                            }
                            .alert(isPresented: $userViewModel.alertDeleted) {
                                Alert(title: Text("Delete account"),
                                      message: Text("Are you sure you want to delete your account?"),
                                      primaryButton: .destructive(Text("Yes")) {

                                          user?.delete { error in
                                              if error != nil {
                                              } else {}
                                              do {
                                                  UserDefaults.standard.removeObject(forKey: "userEmail")
                                                  UserDefaults.standard.removeObject(forKey: userViewModel.nameKey)
                                                  UserDefaults.standard.removeObject(forKey: userViewModel.surNameKey)
                                                  UserDefaults.standard.removeObject(forKey: userViewModel.numberPhoneKey)
                                                  try Auth.auth().signOut()

                                                  UserDefaults.standard.set(false, forKey: "status")
                                                  NotificationCenter.default.post(name: NSNotification.Name("statusChange"),
                                                                                  object: nil)
                                                  fruitViewModel.countCart = 0
                                                  fruitViewModel.isShowCount = false
                                                  fruitViewModel.showCartCount = false
                                                  DispatchQueue.main.async {
                                                      fruitViewModel.arrayOfFruitPrice.removeAll()
                                                      deleteAllRecords()
                                                      fruitViewModel.uniqFruits.removeAll()
                                                  }

                                              } catch {}
                                          }
                                      },
                                      secondaryButton: .cancel())
                            }
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .padding(.leading, 10)
                        }
                        .offset(y: -90)
                        .navigationBarHidden(true)
                    } else {
                        Button {
                            fruitViewModel.showAuth.toggle()
//                            LoginView(signUP: LogIn(), fruitViewModel: fruitViewModel)

                        } label: {
                            Text("Enter or register")
                                .foregroundColor(.white)
                                .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                                .background(Color.theme.orange)
                                .cornerRadius(10)
                                .padding(.bottom, 150)
                        }
                        .padding(.bottom, -60)
                    }
                }
                .fullScreenCover(isPresented: $fruitViewModel.showAuth, content: {
                    LoginView(signUP: LogIn(), fruitViewModel: fruitViewModel)
                })
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

                NotificationCenter.default.addObserver(forName: NSNotification.Name("statusChange"),
                                                       object: nil,
                                                       queue: .main)
                { _ in
                    let status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
                    self.status = status
                }
            }
    }
}
