import SwiftUI

struct AssemblyOfTheOrderView: View {
    @ObservedObject var viewModel = TabBarViewModel()

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ZStack {
                        ZStack {
                            VStack(spacing: 100) {
                                Button {
//                                    self.viewState1 = .zero
//                                    self.viewState2 = .zero

                                    viewModel.viewState = .zero
                                } label: {
                                    Image(systemName: "x.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                }

                                Image(systemName: "cart")
                                    .resizable()
                                    .frame(width: 240, height: 240)
//                                        .padding(.top, 0)
                                    .foregroundColor(.green)
                            }
                        }
                        HStack {

                            VStack {

                                CustomImage(image: "flame")

                                CustomImage(image: "flame")
                                CustomImage(image: "flame")
                                CustomImage(image: "flame")
                                CustomImage(image: "flame")
                                    .padding(.horizontal)

                            }

                            Spacer()
                            VStack {
                                CustomImage(image: "flame")
                                CustomImage(image: "flame")
                                CustomImage(image: "flame")
                                CustomImage(image: "flame")
                                CustomImage(image: "flame")
                                    .padding(.horizontal)

                            }
                        }
//                        .padding(.horizontal)
                    }
                }
                Divider()
                Spacer()
                VStack {}
            }
        }
        .offset(y: -70)

        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}

struct AssemblyOfTheOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AssemblyOfTheOrderView()
    }
}

struct CustomImage: View {
    var image: String
    @ObservedObject var viewModel = TabBarViewModel()
    @State var size = CGSize.zero
    //    @State var wight = CGSize.zero
    var body: some View {
        Image(systemName: image)
            .resizable()
            .frame(width: 30, height: 30)
            .padding()
            .background(.green)
            .clipShape(Circle())
            .blendMode(.hardLight)
            .blur(radius: viewModel.show ? 1 : 0)
            //                            .background(show ? .red : .clear)
            .offset(x: viewModel.viewState.width, y: viewModel.viewState.height)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 1.2))
            .gesture(
                DragGesture().onChanged { value in
                    self.viewModel.viewState = value.translation
                    self.viewModel.show = true
                }
                .onEnded { a in
                    self.viewModel.viewState = a.predictedEndTranslation
                    
                  
                      
                    self.viewModel.show = false
                }
            )
    }
}
