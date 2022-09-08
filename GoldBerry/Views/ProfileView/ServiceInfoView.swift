import SwiftUI

struct ServiceInfoView: View {
    
    @Environment(\.presentationMode) var presentation
    @State var showDeliveryInfoView = false
    @State var showConfidentialView = false
    @State var showDisclaimerOfLiability = false
    @State var showContacts = false
    
    var body: some View {
        VStack {
            Text("О сервисе")
                .foregroundColor(.black)
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .padding()
                .offset(y: -100)
            ZStack {
            Color.theme.gray
                .opacity(0.2)
                .frame(height: 200)
                VStack {
                Text("Версия 1.0.0")
                        .foregroundColor(.gray)
                    .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                    .padding(.bottom, 5)
                Text("\u{24B8} 2022 IVO-Project")
                        .foregroundColor(.gray)
            }
            }
            List {
                Button {
                    self.showDeliveryInfoView.toggle()
                }
            label: {
                HStack {
                        Text("Оплата и доставка")
                        .minimumScaleFactor(0.5)
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                    }
                    .sheet(isPresented: $showDeliveryInfoView, content: {
                        DeliveryInfoView()
                    })
            }
               
                Button {
                    self.showDeliveryInfoView.toggle()
                }
            label: {
                HStack {
                        Text("Положение о конфиденциальности")
                        .minimumScaleFactor(0.5)
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                    }
                    .sheet(isPresented: $showDeliveryInfoView, content: {
                        DeliveryInfoView()
                    })
            }
                
                Button {
                    self.showDeliveryInfoView.toggle()
                }
            label: {
                HStack {
                        Text("Отказ от ответственности")
                        .minimumScaleFactor(0.5)
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                    }
                    .sheet(isPresented: $showDeliveryInfoView, content: {
                        DeliveryInfoView()
                    })
            }
                
                Button {
                    self.showDeliveryInfoView.toggle()
                }
            label: {
                HStack {
                        Text("Контакты")
                        .minimumScaleFactor(0.5)
                            .foregroundColor(.black)
                            .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                        Spacer()
                        Image(systemName: "arrow.right")
                            .resizable()
                            .frame(width: 15, height: 15)
                            .foregroundColor(.gray)
                    }
                    .sheet(isPresented: $showDeliveryInfoView, content: {
                        DeliveryInfoView()
                    })
            }
            }
            .offset(y: -15)
            Spacer()
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
            Image(systemName: "arrow.backward")
            .resizable()
            .frame(width: 20, height: 20)
         .foregroundColor(.black)
            .onTapGesture {
               self.presentation.wrappedValue.dismiss()
            }
         )
    }
}

struct ServiceInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ServiceInfoView()
    }
}
