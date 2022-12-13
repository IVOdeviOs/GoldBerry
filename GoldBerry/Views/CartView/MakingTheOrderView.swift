import CoreData
import iPhoneNumberField
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
    @State var dateOfDelivery: Date?

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>

    func deleteAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "FruitEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try viewContext.execute(deleteRequest)

            try viewContext.save()
        } catch {}
    }

    let prefix = "+375"
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack {
                HStack {
                    Button {
                        self.fruitViewModel.selected = 0
                        self.presentation.wrappedValue.dismiss()
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                            self.fruitViewModel.selected = 1
                        }

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
                        Text("Бесплатная  доставка \nпо Минску от 50р")
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
                    DatePickerTextField(placeholder: "Выберите дату доставки", date: $dateOfDelivery)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                        .padding(.leading, 20)
                        .background(.clear)
                        .frame(height: 50)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.theme.blackWhiteText, lineWidth: 1)
                        )
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
                                HideKeyboard()
                            }
                        ZStack(alignment: .leading) {
                            Text("+375")
                                .foregroundColor(Color.theme.blackWhiteText)
                                .font(Font(uiFont: .fontLibrary(18, .uzSansRegular)))
                                .padding(.leading, 30)
                                .padding(.top, 4)
                            iPhoneNumberField("Телефон получателя", text: $orderViewModel.customerPhone)
                                .maximumDigits(9)
                                .defaultRegion("BY")
                                .foregroundColor(Color.theme.blackWhiteText)
                                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                                .padding(.leading, 55)
                                .background(.clear)
                                .frame(height: 50)
                                .keyboardType(.numberPad)
                                .disableAutocorrection(true)
                                .onTapGesture {
                                    HideKeyboard()
                                }
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(Color.theme.blackWhiteText, lineWidth: 1)
                                )
                                .padding()
                        }
                        TextFieldView(text: $orderViewModel.address, placeholder: "Адрес доставки", infoText: "Введите адрес доставки")
                            .disableAutocorrection(true)
                            .onTapGesture {
                                HideKeyboard()
                            }
                        TextFieldView(text: $orderViewModel.comments, placeholder: "Комментарий", infoText: "Оставьте комментарий к заказу")
                            .onTapGesture {
                                HideKeyboard()
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

                        let dateFormatterOrder = DateFormatter()
                        dateFormatterOrder.dateFormat = "dd.MM.yyyy.HH.mm"
                        let da = dateOfDelivery?.formatted(date: .long, time: .omitted)
                        orderViewModel.date = da ?? "\(dateFormatterOrder.string(from: .now))"
                        orderViewModel.dateOrder = dateFormatterOrder.string(from: .now)

                        let orde = Order(orderNumber: strID,
                                         date: orderViewModel.date,
                                         dateOrder: orderViewModel.dateOrder,
                                         email: email as? String ?? "opsss...",
                                         fruits: fruitViewModel.uniqFruits,
                                         address: orderViewModel.address,
                                         price: orderViewModel.price ?? 0.1 ,
                                         customer: orderViewModel.customer,
                                         customerPhone: "+375" + orderViewModel.customerPhone,
                                         comment: orderViewModel.comments,
                                         orderCompleted: false)
                        Task {
                            do {                                
                                try await orderViewModel.addOrder(orders: orde)
                                tog = true
                                sendRequest { to in
                                    tog = to
                                }
                                fruitViewModel.countCart = 0
                                fruitViewModel.isShowCount = false
                                fruitViewModel.showCartCount = false
                                fruitViewModel.arrayOfFruitPrice.removeAll()
                                fruitViewModel.dictionaryOfNameAndCountOfFruits.removeAll()
                                deleteAllRecords()
  
                            } catch {
                                orderViewModel.showAlertOrder.toggle()
                            }
                        }
                     
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
