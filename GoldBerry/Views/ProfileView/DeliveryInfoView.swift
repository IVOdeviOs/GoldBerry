import SwiftUI

struct DeliveryInfoView: View {
    @ObservedObject var userViewModel: UserViewModel
    var body: some View {

        ScrollView(.vertical, showsIndicators: false) {
            VStack {
               
                HStack {
                    Spacer()
                    Text("Support service")
                        .font(Font(uiFont: .fontLibrary(25, .pFBeauSansProSemiBold)))
                        .foregroundColor(Color.theme.blackWhiteText)
                        .padding()
                    Spacer()
                    Button {
                        userViewModel.showDeliveryInfoView = false
                    } label: {
                        Image(systemName: "x.square")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(.red)
                    }
                    .padding(.trailing,16)
                    
                  
                }
                Text("Contact number")
                    .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProRegular)))
                    .foregroundColor(Color.theme.blackWhiteText)
                Text("+375-29-702-37-01")
                    .font(Font(uiFont: .fontLibrary(24, .pFBeauSansProSemiBold)))
                    .foregroundColor(Color.theme.green4)
                    .padding(.bottom, 5)
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "iphone")
                            .resizable()
                            .frame(width: 50, height: 80)
                            .foregroundColor(Color.theme.orange)
                            .padding(.trailing, -80)
                        Text("Оформляете заказ\n в приложении\n ")
                            .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 60)
                    }
                }
                HStack {
                    VStack {
                        Image(systemName: "phone.circle")
                            .resizable()
                            .frame(width: 80, height: 80)
                            .foregroundColor(Color.theme.orange)
                            .padding(.leading, -80)
                        Text("С Вами свяжется менеджер\nдля согласования\nвремени доставки\n ")
                            .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 60)
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    VStack {
                        Image(systemName: "banknote")
                            .resizable()
                            .frame(width: 80, height: 50)
                            .foregroundColor(Color.theme.orange)
                            .padding(.trailing, -20)
                        Text("Оплачиваете заказ\nбезналичным способом\n ")
                            .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                            .foregroundColor(Color.theme.blackWhiteText)
                            .minimumScaleFactor(0.5)
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 60)
                    }
                }
                    HStack {
                        VStack {
                            Image(systemName: "box.truck.badge.clock")
                                .resizable()
                                .frame(width: 120, height: 80)
                                .foregroundColor(Color.theme.orange)
                                .padding(.leading, -80)
                            Text("Ожидаете доставку товаров\nкурьером\n в согласованное время")
                                .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
                                .foregroundColor(Color.theme.blackWhiteText)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.leading)
                                .padding(.leading, 60)
                        }
                        Spacer()
                    }
//                    Text("Payment and delivery")
//                        .font(Font(uiFont: .fontLibrary(25, .pFBeauSansProSemiBold)))
//                        .foregroundColor(Color.theme.blackWhiteText)
//                    Image(systemName: "rublesign.circle")
//                        .resizable()
//                        .frame(width: 60, height: 60)
//                        .foregroundColor(Color.theme.green4)
//                    Text("Cash payment")
//                        .font(Font(uiFont: .fontLibrary(20, .pFBeauSansProSemiBold)))
//                        .foregroundColor(Color.theme.blackWhiteText)
//                        .padding(.bottom, 5)
//                    Text("You can pay for the goods to the courier upon receipt")
//                        .font(Font(uiFont: .fontLibrary(15, .pFBeauSansProLight)))
//                        .foregroundColor(Color.theme.blackWhiteText)
//                        .minimumScaleFactor(0.5)
                
            }
        }
        .background(Color.theme.background)
    }
}
