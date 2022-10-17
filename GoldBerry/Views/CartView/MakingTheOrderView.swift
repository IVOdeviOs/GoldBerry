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
//                        .onTapGesture {
//                            self.presentation.wrappedValue.dismiss()
//                        }
                    }
                    .padding(.leading,16)
                    Spacer()
                    Text("Оформление заказа")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                    //                .offset(y: -80)
                        .offset(x:-16)
                    Spacer()
                }
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
//                .offset(y: -80)
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
                        TextFieldView(text: $orderViewModel.customer, placeholder: "Имя получателя")
                            .onTapGesture {
                                hideKeyboard()
                            }
                        TextFieldView(text: $orderViewModel.customerPhone, placeholder: "Телефон получателя")
                            .keyboardType(.phonePad)
                            .onTapGesture {
                                hideKeyboard()
                            }
                        TextFieldView(text: $orderViewModel.address, placeholder: "Адрес доставки")
                            .onTapGesture {
                                hideKeyboard()
                            }
                        TextFieldView(text: $orderViewModel.comments, placeholder: "Комментарий")
                            .onTapGesture {
                                hideKeyboard()
                            }
                    }
                    Button {
                        tog = true
                        sendRequest { to in
                            tog = to
                            dismiss()
                            fruitViewModel.isShowCount = false
                            //                        fruitViewModel.selected = 0
                            //                                 tog1 = true
                        }

                        var str = ""
                        var i = 0
                        for char in orderViewModel.id {
                            i += 1
                            if i <= 7 {

                                str.append(char)
                            }
                        }

                        deleteAllRecords()

//                        orderViewModel.dateFormatter()
                        let orde = Order(orderNumber: str,
                                         date: orderViewModel.date,
                                         dateOrder: orderViewModel.dateOrder,
                                         email: email as! String,
                                         fruit: fruitViewModel.uniqFruits,
                                         address: orderViewModel.address,
                                         price: orderViewModel.price ?? 0.1,
                                         customer: orderViewModel.customer,
                                         customerPhone: orderViewModel.customerPhone,
                                         comment: orderViewModel.comments, orderCompleted: false)
                        Task {
                            do {
                                try await orderViewModel.addOrder(orders: orde)

                            } catch {
                                print("❌ ERORR")
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
                    //                .fullScreenCover(isPresented: $tog1) {
                    //                    ContentView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
                    //                }
                }
                Spacer()
            }
        }
        .onAppear {
            orderViewModel.isFormValid
                .receive(on: RunLoop.main)
                .assign(to: \.orderViewModel.isValid, on: self)
                .store(in: &orderViewModel.cancellable)

        }
//        .offset(y: 15)
//        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
//        .navigationBarItems(leading:
//            Image(systemName: "arrow.backward")
//                .resizable()
//                .frame(width: 18, height: 18)
//                .foregroundColor(.black)
//                .onTapGesture {
//                    self.presentation.wrappedValue.dismiss()
//                }
//        )
    }
}

// struct MakingTheOrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        MakingTheOrderView(viewModel: FruitViewModel(), orderFruit: [Fruit(cost: 13, weightOrPieces: "", categories: "", favorite: false, count: 1, image: "", name: "")])
//    }
// }
