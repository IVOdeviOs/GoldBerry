import SwiftUI

struct InformationProductView: View {
    @ObservedObject var viewModel = TabBarViewModel()
    @Environment(\.presentationMode) var presentationMode

    private func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }

    var body: some View {

        ZStack(alignment: .top) {

            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    ZStack(alignment: .top) {
                        Image("fresh")
                            .resizable()
                            .frame(height: 350)
                            .aspectRatio(contentMode: .fit)
                    }
                    .cornerRadius(30)
                    .padding(3)
                    Spacer()
                    HStack {
                        Image(systemName: "car")
                            .resizable()
                            .frame(width: 35, height: 35)
                            .foregroundColor(Color.theme.gray)
                        Text("Бесплатная доставка от ... ₽")
                            .font(.system(size: 16, weight: .medium, design: .default))
                        Spacer()
                    }
                    .padding(13)
                    .background(.gray.opacity(0.3))
                    .cornerRadius(20)
                    .padding(.horizontal)
                    HStack {
                        Text("1245₽")
                            .foregroundColor(.red)
                            .font(.system(size: 23, weight: .bold, design: .default))
                        ZStack {
                            Text("4500₽")
                                .font(.system(size: 13, weight: .light, design: .serif))
                                .foregroundColor(.black.opacity(0.6))
                            Color(CGColor(gray: 0, alpha: 1)).opacity(0.5)
                                .frame(width: 45, height: 0.5)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)

                    HStack {
                        Text("adsgkhagsdkha;sdgihg;asidgh;iagshd;ighda;siohg;asdoihg;aiosdhgahsdg;ioh;ashgaisdfsadfadsgadsgadsgadsgasdgadsgasadsgkhagsdkha;sdgihg;asidgh;iagshd;ighda;siohg;asdoihg;aiosdhgahsdg;ioh;ashgaisdfsadfadsgadsgadsgadsgasdgadsgashgohgoadsgkhagsdkha;sdgihg;asidgh;iagshd;ighda;siohg;asdoihg;aiosdhgahsdg;ioh;ashgaisdfsadfadsgadsgadsgadsgasdgadsgasadsgkhagsdkha;sdgihg;asidgh;iagshd;ighda;siohg;asdoihg;aiosdhgahsdg;ioh;ashgaisdfsadfadsgadsgadsgadsgasdgadsgashgohgo")
                            .font(.system(size: 16, weight: .medium, design: .default))
                        Spacer()
                    }

                    .frame(minHeight: 70, maxHeight: 150)
                    .padding(.horizontal)
                    
                   
//                    .padding(.vertical,2)
                }
                .offset(y: -35)
                .navigationBarHidden(true)
            }

            ZStack {
                VStack{
                HStack {
                    Button {
                        dismiss()

                    } label: {
                        Image(systemName: "arrow.backward.square")
                            .renderingMode(.original)
                            .scaleEffect(3)
                            .foregroundColor(Color.theme.lightGreen)
                            .frame(width: 60, height: 60)
                            .background(.white.opacity(0.3))
                            .cornerRadius(10)
                    }
                    Spacer()
                    Button {
                        //
                    } label: {
                        Image(systemName: "heart")
                            .renderingMode(.template)
                            .scaleEffect(3)
                            .foregroundColor(.red)
                            .frame(width: 60, height: 60)
                            .background(.white.opacity(0.3))
                            .cornerRadius(10)
                    }
                }
                .padding(.horizontal)
//                .padding(.top, 1)
                    Spacer()
                VStack {
                    Button {
                        print("🥶")
                    } label: {
                        HStack {
                            Text("В корзину")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold, design: .serif))
                            Spacer()
                            Text("1245₽")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .bold, design: .serif))
                        }
                        .padding()
                        .background(Color.theme.lightGreen)
                        .cornerRadius(20)
                        .padding(.horizontal, 16)
                    }
                }
                .offset(y:-75)
            }
            }
        }
    }
}

struct InformationProductView_Previews: PreviewProvider {
    static var previews: some View {
        InformationProductView()
    }
}
