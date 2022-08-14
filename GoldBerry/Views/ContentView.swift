import SwiftUI
extension Color {
    static let lightShadow = Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255)
    static let darkShadow = Color(red: 163 / 255, green: 177 / 255, blue: 198 / 255)
    static let background = Color(red: 224 / 255, green: 229 / 255, blue: 236 / 255)
    static let neumorphismtextColor = Color(red: 132 / 255, green: 132 / 255, blue: 132 / 255)
}

struct ContentView: View {
    @ObservedObject var viewModel = TabBarViewModel()
    var body: some View {

        NavigationView {
            ZStack {
                ZStack {
                    switch viewModel.selected {
                    case 0:
                        ProductsView()
                    case 1:
                        AssemblyOfTheOrderView()
                    case 2:
                        OrdersView()

                    default:
                        OrdersView()
                    }
                }
                //            .padding()
                .padding(.top, 90)
                ZStack {
                    VStack {
                        ZStack {
                            HStack {
                                Text("GoldBerry")
                                    .font(.system(size: 30, weight: .bold, design: .monospaced))
                                    .foregroundColor(.green)
                                    .padding()
                                Spacer()
                                HStack {
                                    Image(systemName: "cart.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.green)
                                    Spacer()
                                    VStack {

                                        Text("100000")
                                            .font(.system(size: 12, weight: .light, design: .monospaced))
                                            .foregroundColor(.black)
                                        Text("руб")
                                            .font(.system(size: 12, weight: .light, design: .monospaced))
                                            .foregroundColor(.black)
                                    }
                                }
                                .padding()
                                .frame(width: 120, height: 40)
                                .background(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                                .shadow(color: .green.opacity(0.2), radius: 10, x: 0, y: 10)
                                .padding(.horizontal, 30)
                            }
                            .padding(.top, 60)
                        }

                        Spacer()
                        ZStack(alignment: .bottom) {
                            HStack {
                                Button {
                                    viewModel.selected = 0
                                } label: {
                                    Image(systemName: "house")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                }.foregroundColor(viewModel.selected == 0 ? .green : .gray)
                                Spacer(minLength: 12)
                                Button {
                                    viewModel.selected = 1
                                } label: {
                                    Image(systemName: "video")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                }.foregroundColor(viewModel.selected == 1 ? .green : .gray)
                                Spacer()

                                Button {
                                    viewModel.selected = 2
                                } label: {
                                    Image(systemName: viewModel.selected == 2 ? "bag.fill" : "bag")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                }.foregroundColor(viewModel.selected == 2 ? .green : .gray)
                                Spacer(minLength: 12)

                                Button {
                                    viewModel.selected = 3
                                } label: {
                                    Image(systemName: viewModel.selected == 3 ? "person.fill" : "person")
                                        .resizable()
                                        .frame(width: 23, height: 20)
                                }.foregroundColor(viewModel.selected == 3 ? .green : .gray)
                            }
                            .padding()
                            .padding(.horizontal, 22)
                            //                        .background(Color.background)
                            .background(.white)
                        }

                        //                    .padding()
                        //                    .foregroundColor(Color.neumorphismtextColor)
                        //                    .background(Color.background)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding()
                        //                    .shadow(color: Color.lightShadow, radius: 5, x: -4, y: -4)
                        //                    .shadow(color: Color.darkShadow, radius: 5, x: 4, y: 4)
                        .padding(.bottom, 30)
                        .shadow(color: .green.opacity(0.5), radius: 20, x: 0, y: 10)
                    }
                }
            }
            .ignoresSafeArea()
            .background(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
