import CoreData
import SwiftUI
struct MakingTheOrderView: View {

    func sendRequest(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            completion(tog == false)
        }
    }

    @Environment(\.presentationMode) var presentation
    @ObservedObject var orderViewModel = OrderViewModel()
    @ObservedObject var fruitViewModel = FruitViewModel()

    @State var tog = false
    @State var tog1 = false

    func deleteAllRecords(entity: String) {
        let managedContext = viewContext // your context
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try managedContext.execute(deleteRequest)
            try managedContext.save()
        } catch {
            print("There was an error")
        }
    }

    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: []
    )
    var fruits: FetchedResults<FruitEntity>
//    @State var orderFruit = [Fruit]()

    var body: some View {
        VStack {
            Text("Оформление заказа")
                .foregroundColor(.black)
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .offset(y: -80)
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
                .offset(y: -80)
            ScrollView {
                HStack {
                    Text("Доставка по Минску \nБесплатная доставка")
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                        .padding()
                    Spacer()
                    Image(systemName: "record.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.theme.lightGreen)
                        .padding()
                }
                .background(.white)
                .frame(height: 60)
                .cornerRadius(10)
                .shadow(color: .gray, radius: 2, x: 1, y: 1)
                .padding()
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
                HStack {
                    Text("Когда доставить \(fruitViewModel.uniqFruits.count)")
                        .foregroundColor(.black)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                        .padding()
                    Spacer()
                    Image(systemName: "clock.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundColor(Color.theme.lightGreen)
                        .padding()
                }
                DatePicker("", selection: $orderViewModel.deliveryDate)
                    .datePickerStyle(.compact)

                    .padding()
                VStack {
                    HStack {
                        Text("Куда доставить")
                            .foregroundColor(.black)
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
                        .keyboardType(.numberPad)
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
                        //                        fruitViewModel.selected = 0
                        //                                 tog1 = true
                    }

                    deleteAllRecords(entity: "FruitEntity")

                    orderViewModel.dateFormatter()
                    let orde = Order(orderNumber: orderViewModel.order.count,
                                     date: orderViewModel.date,
                                     email: orderViewModel.email as! String,
                                     fruit: fruitViewModel.uniqFruits,
                                     address: orderViewModel.address,
                                     price: orderViewModel.price ?? 0.1,
                                     customer: orderViewModel.customer,
                                     customerPhone: orderViewModel.customerPhone,
                                     comment: orderViewModel.comments)
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
                        .background(Color.theme.lightGreen)
                        .cornerRadius(10)
                }
                .fullScreenCover(isPresented: $tog) {
                    CompletedOrderView()
                }
                .fullScreenCover(isPresented: $tog1) {
                    ContentView(fruitViewModel: fruitViewModel, orderViewModel: orderViewModel)
                }
            }
            Spacer()
        }
        .offset(y: -15)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Image(systemName: "arrow.backward")
                .resizable()
                .frame(width: 18, height: 18)
                .foregroundColor(.black)
                .onTapGesture {
                    self.presentation.wrappedValue.dismiss()
                }
        )
    }

//    func deleteAllRecords() {
//        let entity = "FruitEntity"
//
//        let managedContext = viewContext // your context
//        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: entity)
//        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//
//        do {
//            try managedContext.execute(deleteRequest)
//            try managedContext.save()
//        } catch {
//            print("There was an error")
//        }
//    }
}

// struct MakingTheOrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        MakingTheOrderView(viewModel: FruitViewModel(), orderFruit: [Fruit(cost: 13, weightOrPieces: "", categories: "", favorite: false, count: 1, image: "", name: "")])
//    }
// }
