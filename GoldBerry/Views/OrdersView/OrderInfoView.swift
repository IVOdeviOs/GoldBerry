
import SwiftUI

struct OrderInfoView: View {

    var order: Order
    @Environment(\.presentationMode) var presentation
    var body: some View {

        VStack {
            VStack {
                HStack {
                    Text("Order №")
                        .font(Font(uiFont: .fontLibrary(24, .pFBeauSansProSemiBold)))
                        .foregroundColor(Color.theme.blackWhiteText)
                    Text("\(order.orderNumber)")
                        .font(Font(uiFont: .fontLibrary(24, .pFBeauSansProSemiBold)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding()
                }
                Color.theme.gray
                    .opacity(0.3)
                    .frame(height: 10)
                HStack {
//                    HStack {
//                        Text("$ ")
//                            .font(Font(uiFont: .fontLibrary(16, .pFBeauSansProSemiBold)))
//                            .foregroundColor(.white)

                        Text(" \(NSString(format: "%.2f", order.prices)) руб")
                            .font(Font(uiFont: .fontLibrary(16, .pFBeauSansProSemiBold)))
                            .foregroundColor(.white)
//                    }
                    .frame(width: 130, height: 30)
                    .background(.orange)
                    .cornerRadius(8)
                    .padding()
                    Spacer()
                    Text("\(order.dateOrder)")
                        .foregroundColor(Color.theme.gray)
                        .font(Font(uiFont: .fontLibrary(16, .pFBeauSansProRegular)))
                        .padding()
                }
                HStack {
                    Spacer()
                    Text("Product name")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
                        .frame(width: UIScreen.main.bounds.width / 3, height: 20)
                    Text("Price")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
                        .frame(width: UIScreen.main.bounds.width / 6, height: 20)
                    Text("Count")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
                        .frame(width: UIScreen.main.bounds.width / 6, height: 20)
                    Text("Total")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
                        .frame(width: UIScreen.main.bounds.width / 6, height: 20)
                        .padding(.trailing, 20)
                }
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
                                    .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
                                    .frame(width: UIScreen.main.bounds.width / 4, height: 20)
//                                HStack(spacing: 1) {
//                                    Text("$ ")
//                                        .foregroundColor(Color.theme.blackWhiteText)
//                                        .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
                                    Text(" \(NSString(format: "%.2f", order.fruits[row].itog)) руб")
                                        .foregroundColor(Color.theme.blackWhiteText)
                                        .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
//                                }
                                .frame(width: UIScreen.main.bounds.width / 6, height: 20)
                                Text("\(NSString(format: "%.1f", order.fruits[row].count))")
                                    .foregroundColor(Color.theme.blackWhiteText)
                                    .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
                                    .frame(width: UIScreen.main.bounds.width / 6, height: 20)
//                                HStack(spacing: 1) {
//                                    Text("$ ")
//                                        .foregroundColor(Color.theme.blackWhiteText)
//                                        .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
                                    Text(" \(NSString(format: "%.2f", order.fruits[row].itog * Double(order.fruits[row].count))) руб")
                                        .foregroundColor(Color.theme.blackWhiteText)
                                        .font(Font(uiFont: .fontLibrary(12, .pFBeauSansProRegular)))
//                                }
                                .frame(width: UIScreen.main.bounds.width / 6, height: 20)
                                .padding(.trailing, 10)
                            }
                        }
                    }
                }.frame(height: 200)
                Color.theme.grafit
                    .opacity(0.3)
                    .frame(height: 10)
                HStack {
                    Image(systemName: "suitcase.cart")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Text("Delivery")
                        .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Spacer()
                }
                HStack {
                    Text("\(order.date)")
                        .font(Font(uiFont: .fontLibrary(16, .pFBeauSansProRegular)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding(.leading, 10)
                        .padding(.bottom, 10)
                    Spacer()
                }
                Color.theme.grafit
                    .opacity(0.3)
                    .frame(height: 10)
                CustomerInfo(order: order)
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
                switch value.translation.width {
                case 0 ... 500: self.presentation.wrappedValue.dismiss()
                default: break
                }
            }
        )
    }
}

struct CustomerInfo: View {

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
                Text("Recipient")
                    .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                    .foregroundColor(Color.theme.blackWhiteText)
                    .padding(.leading, 10)
                    .padding(.bottom, 10)
                Spacer()
            }
            Text("\(order.customer)")
                .font(Font(uiFont: .fontLibrary(16, .pFBeauSansProRegular)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.leading, 10)
            Text("\(order.customerPhone)")
                .font(Font(uiFont: .fontLibrary(16, .pFBeauSansProRegular)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.leading, 10)
            Text("\(order.address)")
                .font(Font(uiFont: .fontLibrary(16, .pFBeauSansProRegular)))
                .foregroundColor(Color.theme.blackWhiteText)
                .padding(.leading, 10)
            Color.theme.grafit
                .opacity(0.3)
                .frame(height: 10)
            Spacer()
        }
    }
}
