import CoreData
import SwiftUI
struct MakingTheOrderView: View {

    func sendRequest(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            fruitViewModel.selected = 0

            completion(tog == false)
        }
    }

    let email = UserDefaults.standard.value(forKey: "userEmail")
    let phone = UserDefaults.standard.value(forKey: "numberPhoneKey")
    @Environment(\.presentationMode) var presentation
    @Environment(\.dismiss) private var dismiss

    @ObservedObject var orderViewModel: OrderViewModel
    @ObservedObject var fruitViewModel: FruitViewModel

    @State var tog = false
    @State var tog1 = false

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>

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
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Button {
                        self.presentation.wrappedValue.dismiss()

                    } label: {
                        Image(systemName: "arrow.backward")
                            .resizable()
                            .frame(width: 18, height: 18)
                            .foregroundColor(Color.theme.blackWhiteText)
                    }
                    .padding(.leading, 16)
                    Spacer()
                    Text("Оформление заказа")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                        .offset(x: -16)
                    Spacer()
                }
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
                ScrollView {
                    HStack {
                        Text("Бесплатная  доставка \nпо Минску")
                            .fixedSize(horizontal: false, vertical: true)
                            .foregroundColor(Color.theme.blackWhiteText)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                            .padding()
                        Spacer()
                        Image(systemName: "record.circle")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.theme.lightGreen)
                            .padding()
                    }
                    .background(Color.theme.background)
                    .frame(height: 45)
                    .cornerRadius(10)
                    .shadow(color: .gray, radius: 2, x: 1, y: 1)
                    .padding()
                    Color.theme.gray
                        .opacity(0.3)
                        .frame(height: 10)
                    HStack {
                        Text("Когда доставить")
                            .foregroundColor(Color.theme.blackWhiteText)
                            .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                            .padding()
                        Spacer()
                        Image(systemName: "clock.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                            .foregroundColor(Color.theme.lightGreen)
                            .padding()
                    }
                    DatePicker("", selection: $orderViewModel.deliveryDate, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .onTapGesture(perform: {
                            orderViewModel.dateFormatter()

                        })
                        .padding()
                    VStack {
                        HStack {
                            Text("Куда доставить")
                                .foregroundColor(Color.theme.blackWhiteText)
                                .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                                .padding()
                            Spacer()
                            Image(systemName: "house.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color.theme.lightGreen)
                                .padding()
                        }
                        TextFieldView(text: $orderViewModel.customer, placeholder: "Имя получателя", infoText: "Введите имя получателя")
                            .disableAutocorrection(true)
                            .onTapGesture {
                                hideKeyboard()
                            }
                        TextFieldView(text: $orderViewModel.customerPhone, placeholder: "Телефон получателя", infoText: "В формате (375)(80)29 1234567")
                            .keyboardType(.numberPad)
                            .disableAutocorrection(true)
                            .onTapGesture {
                                hideKeyboard()
                            }
                        TextFieldView(text: $orderViewModel.address, placeholder: "Адрес доставки", infoText: "Введите адрес доставки")
                            .disableAutocorrection(true)
                            .onTapGesture {
                                hideKeyboard()
                            }
                        TextFieldView(text: $orderViewModel.comments, placeholder: "Комментарий", infoText: "Оставте комментарий к заказу")
                            .onTapGesture {
                                hideKeyboard()
                            }
                    }
                    Button {

                        var strID = ""
                        var numberId = 0
                        for char in UUID().uuidString {
                            numberId += 1
                            if numberId <= 7 {
                                strID.append(char)
                            }
                        }

                        let orde = Order(orderNumber: strID,
                                         date: orderViewModel.date,
                                         dateOrder: orderViewModel.dateOrder,
                                         email: email as? String ?? "opsss...",
                                         fruits: fruitViewModel.uniqFruits,
                                         address: orderViewModel.address,
                                         price: orderViewModel.price ?? 0.1,
                                         customer: orderViewModel.customer,
                                         customerPhone: orderViewModel.customerPhone,
                                         comment: orderViewModel.comments,
                                         orderCompleted: false)
                        Task {
                            do {
                                DispatchQueue.main.async {
                                    fruitViewModel.uniqFruits.removeAll()

                                }
                                try await orderViewModel.addOrder(orders: orde)
                                tog = true
                                sendRequest { to in
                                    tog = to
                                 
                                    fruitViewModel.isShowCount = false
                                }
                                deleteAllRecords()
                                
//                                for ite in  fruitViewModel.arrayOfFruitPrice.keys {
//                                    fruitViewModel.arrayOfFruitPrice.removeValue(forKey: ite)
//                                    print("💵\(fruitViewModel.arrayOfFruitPrice.count)")
//                                }
//                                for ite in  fruitViewModel.dictionaryOfNameAndCountOfFruits.keys {
//                                    fruitViewModel.dictionaryOfNameAndCountOfFruits.removeValue(forKey: ite)
//                                    print("🍔\(fruitViewModel.dictionaryOfNameAndCountOfFruits.count)")
//                                }
                            } catch {
                                orderViewModel.showAlertOrder.toggle()
                                print("❌ ERORR  \(error.localizedDescription)")
                            }
                        }
                        fruitViewModel.countCart = 0
                        fruitViewModel.showCartCount = false
                    } label: {
                        Text("Сделать заказ")
                            .foregroundColor(.white)
                            .frame(width: 300, height: 50)
                            .background(orderViewModel.isValid ? Color.theme.lightGreen : Color.gray)
                            .cornerRadius(10)
                    }
                    .disabled(!orderViewModel.isValid)
                    .fullScreenCover(isPresented: $tog) {
                        CompletedOrderView()
                    }
                }
                Spacer()
            }.sheet(isPresented: $orderViewModel.showAlertOrder) {
                AlertMakingOrder()
            }
        }

        .gesture(DragGesture(minimumDistance: 100.0, coordinateSpace: .local)
            .onEnded { value in

                switch value.translation.width {
                case 100 ... 300: self.presentation.wrappedValue.dismiss()
                default: print("no clue")
                }
            }
        )
        .onAppear {
            orderViewModel.customerPhone = phone as? String ?? ""
            orderViewModel.isFormValid
                .receive(on: RunLoop.main)
                .assign(to: \.orderViewModel.isValid, on: self)
                .store(in: &orderViewModel.cancellable)
        }

        .navigationBarBackButtonHidden(true)
    }
}
