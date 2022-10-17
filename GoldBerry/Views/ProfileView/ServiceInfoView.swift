import SwiftUI

struct ServiceInfoView: View {
    
    @Environment(\.presentationMode) var presentation
    @State var showDeliveryInfoView = false
    @State var showConfidentialView = false
    @State var showDisclaimerOfLiability = false
    @State var showContacts = false
    var numberPhone = "+375336096300"
    
    var body: some View {
        VStack {
            Text("О сервисе")
                .foregroundColor(Color.theme.blackWhiteText)
                .font(Font(uiFont: .fontLibrary(20, .uzSansBold)))
                .padding()
                .offset(y: -100)
            ZStack {
                Color.theme.grayWhite
                    .opacity(0.2)
                    .frame(height: 200)
                VStack {
                    Text("Версия 1.0.0")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .opacity(0.5)
                        .font(Font(uiFont: .fontLibrary(20, .uzSansSemiBold)))
                        .padding(.bottom, 5)
                    Text("\u{24B8} 2022 DMTeam")
                        .foregroundColor(Color.theme.blackWhiteText)
                        .opacity(0.5)
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
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    Spacer()
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color.theme.blackWhiteText)
                }
                .sheet(isPresented: $showDeliveryInfoView, content: {
                    DeliveryInfoView()
                })
            }
                
                Button {
                    self.showConfidentialView.toggle()
                }
            label: {
                HStack {
                    Text("Положение о конфиденциальности")
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    Spacer()
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color.theme.blackWhiteText)
                }
                .sheet(isPresented: $showConfidentialView, content: {
                    ConfidentialView()
                })
            }
                
                Button {
                    self.showDisclaimerOfLiability.toggle()
                }
            label: {
                HStack {
                    Text("Отказ от ответственности")
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    Spacer()
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color.theme.blackWhiteText)
                }
                .sheet(isPresented: $showDisclaimerOfLiability, content: {
                    DisclaimerOfLiability()
                })
            }
                
                Button {
                    let formattedString = "tel://" + numberPhone
                    guard let url = URL(string: formattedString) else { return }
                    UIApplication.shared.open(url)
                }
            label: {
                HStack {
                    Text("Контакты")
                        .minimumScaleFactor(0.5)
                        .foregroundColor(Color.theme.blackWhiteText)
                        .font(Font(uiFont: .fontLibrary(15, .uzSansRegular)))
                    Spacer()
                    Image(systemName: "arrow.right")
                        .resizable()
                        .frame(width: 15, height: 15)
                        .foregroundColor(Color.theme.blackWhiteText)
                }
            }
            }
            .offset(y: -15)
            
            Link(destination: URL(string: "https://www.instagram.com/nar_juice")!) {
                Image("instagram")
                    .resizable().frame(width: 60, height: 60).padding()
//                    .font(.largeTitle)
                
            }
            Spacer()
        }
        
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Image(systemName: "arrow.backward")
            .resizable()
            .frame(width: 20, height: 20)
            .foregroundColor(Color.theme.blackWhiteText)
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
