import CoreData
import SwiftUI
struct MakingTheOrderView: View {

    func sendRequest(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            completion(tog == false)
        }
    }

    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel: FruitViewModel
    @State var tog = false
    @State var tog1 = false

    @State var deliveryDate = Date()
    func dateFormatter() {
        @State var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
        viewModel.date = dateFormatter.string(from: deliveryDate)
    }

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \FruitEntity.name, ascending: true)],
        animation: .default
    )
    var fruits: FetchedResults<FruitEntity>

    @State var orderFruit = [Fruit]()
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
                    Text("Когда доставить")
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
                DatePicker("", selection: $deliveryDate)
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
                    TextFieldView(text: $viewModel.customer, placeholder: "Имя получателя")
                        .onTapGesture {
                            hideKeyboard()
                        }
                    TextFieldView(text: $viewModel.customerPhone, placeholder: "Телефон получателя")
                        .keyboardType(.numberPad)
                        .onTapGesture {
                            hideKeyboard()
                        }
                    TextFieldView(text: $viewModel.address, placeholder: "Адрес доставки")
                        .onTapGesture {
                            hideKeyboard()
                        }
                    TextFieldView(text: $viewModel.comment, placeholder: "Комментарий")
                        .onTapGesture {
                            hideKeyboard()
                        }
                }
                Button {
                    self.tog = true
                    sendRequest { to in
                        tog = to
                        tog1 = true
                    }
                    dateFormatter()
                    print(viewModel.date)

                    func currentTopics(fruitss: FetchedResults<FruitEntity>) -> [Fruit] {
                        var collected = [Fruit]()
                        for item in viewModel.fruit {
                            for i in fruitss {
                                if i.id == item.id {

                                    let col = Fruit(id: item.id,
                                                       cost: item.cost,
                                                       weightOrPieces: item.weightOrPieces,
                                                       categories: item.categories,
                                                       favorite: item.favorite,
                                                       count: item.count,
                                                       image: item.image,
                                                       name: item.name,
                                                       percent: item.percent,
                                                       descriptions: item.descriptions,
                                                       price: item.price,
                                                       comment: item.comment)
                                    collected.append(col)
                                }
                            }
                        }

                        return collected
                    }
                    let orde = Order(orderNumber: viewModel.orderNumber,
                                     date: viewModel.date, fruit: currentTopics(fruitss: fruits),
                                     address: viewModel.address,
                                     price: Int(viewModel.price),
                                     customer: viewModel.customer,
                                     customerPhone: viewModel.customerPhone,
                                     comment: viewModel.comment)
//
                    Task {
                        do {
                            try await viewModel.addOrder(orders: orde)
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
                    ContentView(viewModel: FruitViewModel())
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
}

struct MakingTheOrderView_Previews: PreviewProvider {
    static var previews: some View {
        MakingTheOrderView(viewModel: FruitViewModel(), orderFruit: [Fruit(cost: 13, weightOrPieces: "", categories: "", favorite: false, count: 1, image: "", name: "")])
    }
}
