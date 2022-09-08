import SwiftUI

struct MakingTheOrderView: View {

    func sendRequest(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            completion(tog == false)
        }
    }

    @Environment(\.presentationMode) var presentation
    @ObservedObject var viewModel: FruitViewModel
    @State var tog = false
    @State var tog1 = false

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
                }
                TextFieldView(text: $viewModel.date, placeholder: "Выбрать дату и время")
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
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
                    TextFieldView(text: $viewModel.customerPhone, placeholder: "Телефон получателя")
                    TextFieldView(text: $viewModel.address, placeholder: "Адрес доставки")
                    TextFieldView(text: $viewModel.comment, placeholder: "Комментарий")
                }
                Button {
                    self.tog = true
                    sendRequest { to in
                        tog = to
                        tog1 = true
                    }
                    let orde = Order(orderNumber: viewModel.orderNumber,
                                     date: viewModel.date, fruit: viewModel.fruit,
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
        MakingTheOrderView(viewModel: FruitViewModel())
    }
}
