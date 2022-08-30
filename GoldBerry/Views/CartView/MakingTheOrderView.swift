import SwiftUI

struct MakingTheOrderView: View {
    
    func sendRequest(completion: @escaping (Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            completion(tog == false)
        }
    }
    @Environment(\.presentationMode) var presentation
    @StateObject var viewModels: OrderViewModel
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
                TextFieldView(text: $viewModels.order.date, placeholder: "Выбрать дату и время")
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
                OrderInformation(viewModels: OrderViewModel())
                Button {
                    self.tog = true
                    sendRequest { to in
                        tog = to
                        tog1 = true
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
                    ContentView(viewModel: FruitViewModel(), viewModels: OrderViewModel())
                }
                
            }
            Spacer()
            
        }
        .offset( y: -15)
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
        MakingTheOrderView(viewModels: OrderViewModel())
    }
}

struct OrderInformation: View {
    
    @StateObject var viewModels: OrderViewModel
    
    var body: some View {
        
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
            TextFieldView(text: $viewModels.order.customer, placeholder: "Имя получателя")
            TextFieldView(text: $viewModels.order.customerPhone, placeholder: "Телефон получателя")
            TextFieldView(text: $viewModels.order.address, placeholder: "Адрес доставки")
            TextFieldView(text: $viewModels.order.comment, placeholder: "Комментарий")
        }
    }
}
