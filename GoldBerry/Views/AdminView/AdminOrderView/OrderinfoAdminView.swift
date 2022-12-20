import SwiftUI

struct OrderInfoAdminView: View {

    var order: Order
    @ObservedObject var adminViewModel: AdminViewModel

    @Environment(\.presentationMode) var presentation
    func updateOrder() async throws {
        let urlString = Constants.baseURL + EndPoints.order

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let orderUpdate = Order(id: order.id,
                                orderNumber: order.orderNumber,
                                date: order.date,
                                dateOrder: order.dateOrder,
                                email: order.email,
                                fruits: order.fruits,
                                address: order.address,
                                price: order.price,
                                customer: order.customer,
                                customerPhone: order.customerPhone,
                                comment: order.comment,
                                orderCompleted: true)

        try await HttpClient.shared.sendData(to: url, object: orderUpdate, httpMethod: HttpMethods.PUT.rawValue)
    }

    var body: some View {

        VStack {
            VStack {
                Text("Заказ № \(order.orderNumber)")
                    .font(Font(uiFont: .fontLibrary(24, .uzSansBold)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .padding()
//                Color.theme.gray
//                    .opacity(0.3)
//                    .frame(height: 10)
                HStack {
                    Text("\(NSString(format: "%.2f", order.price)) p.")
                        .font(Font(uiFont: .fontLibrary(16, .uzSansBold)))
                        .foregroundColor(.white)
                        .frame(width: 130, height: 30)
                        .background(.orange)
                        .cornerRadius(8)
                        .padding()
                    Spacer()
                    Text("\(order.dateOrder)")
                        .foregroundColor(Color.theme.gray)
                        .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                        .padding()
                }
                Info()
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(0 ..< order.fruits.count) { row in
                        if order.fruits[row].favorite {} else {
                            HStack {
                                AsyncImage(
                                    url: URL(string: order.fruits[row].image),
                                    transaction: Transaction(animation: .easeInOut)
                                ) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                    case .success(let image):
                                        image
                                            .resizable()
                                            .transition(.scale(scale: 0.1, anchor: .center))
                                            .frame(width: 30, height: 20)
                                            .aspectRatio(contentMode: .fill)
                                    case .failure:
                                        Image(systemName: "wifi.slash")
                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                
                                .frame(width: 30, height: 20)
                                .cornerRadius(5)
                                .padding(.leading, 10)
                                Text(order.fruits[row].name)
                                    .minimumScaleFactor(0.7)
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                    .frame(width: UIScreen.main.bounds.width / 4, height: 20)
                                Text("\(NSString(format: "%.2f", order.fruits[row].itog)) p.")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                    .frame(width: UIScreen.main.bounds.width / 6, height: 20)
                                Text("\(NSString(format: "%.1f", order.fruits[row].count))")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                    .frame(width: UIScreen.main.bounds.width / 6, height: 20)
                                Text("\(NSString(format: "%.2f", order.fruits[row].itog * Double(order.fruits[row].count))) p.")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                                    .frame(width: UIScreen.main.bounds.width / 6, height: 20)
                                    .padding(.trailing, 10)
                            }
                        }
                    }
                }.frame(height: 200)
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
                HStack {
                    Image(systemName: "suitcase.cart")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Text("Доставка")
                        .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Spacer()
                }
                HStack {
                    Text("\(order.date)")
                        .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Spacer()
                }
                UserInfo(order: order)
                Spacer()
                if order.orderCompleted == true {} else {
                    Button {
                        Task {
                            do {
                                try await updateOrder()
                                self.presentation.wrappedValue.dismiss()
                            } catch {}
                        }
                    } label: {
                        Text("Отметить как выполненный")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .light, design: .serif))
                    }
                    .frame(width: 250, height: 40)
                    .background(Color.theme.lightGreen)
                    .cornerRadius(6)
                    .padding(8)
                    .shadow(color: Color.theme.blackWhiteText, radius: 2)
                    .padding(.bottom, 100)
                }
            }
        }
        .offset(y: 35)
        .ignoresSafeArea()
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Image(systemName: "arrow.backward")
                .resizable()
                .foregroundColor(Color.theme.blackWhiteText)
                .frame(width: 22, height: 20)
                .padding(.top, 18)
                .foregroundColor(.black)
                .onTapGesture {
                    self.presentation.wrappedValue.dismiss()
                }
        )
        .gesture(DragGesture(minimumDistance: 50.0, coordinateSpace: .local)
            .onEnded { value in
                print(value.translation)
                switch value.translation.width {
                case 0 ... 500: self.presentation.wrappedValue.dismiss()
                default: break
                }
            }
        )
    }
}

struct Info: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Наименование")
                .foregroundColor(Color.theme.blackWhiteText)
                .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                .frame(width: UIScreen.main.bounds.width / 3, height: 20)
            Text("Цена/ед.")
                .foregroundColor(Color.theme.blackWhiteText)
                .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                .frame(width: UIScreen.main.bounds.width / 6, height: 20)
            Text("Кол-во")
                .foregroundColor(Color.theme.blackWhiteText)
                .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                .frame(width: UIScreen.main.bounds.width / 6, height: 20)
            Text("Итого")
                .foregroundColor(Color.theme.blackWhiteText)
                .font(Font(uiFont: .fontLibrary(12, .uzSansRegular)))
                .frame(width: UIScreen.main.bounds.width / 6, height: 20)
                .padding(.trailing, 20)
        }
    }
}

struct UserInfo: View {

    var order: Order

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Image(systemName: "face.smiling")
                    .resizable()
                    .foregroundColor(Color.theme.blackWhiteText)
                    .frame(width: 25, height: 25)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                Text("Получатель")
                    .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                Spacer()
            }
            Text("\(order.customer)")
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.leading, 10)
            Text("\(order.customerPhone)")
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.leading, 10)
            Text("\(order.address)")
                .font(Font(uiFont: .fontLibrary(16, .uzSansRegular)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.leading, 10)
            Color.theme.gray
                .opacity(0.3)
                .frame(height: 10)
        }
    }
}
