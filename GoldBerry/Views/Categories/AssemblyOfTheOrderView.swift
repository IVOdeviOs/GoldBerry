import SwiftUI

struct AssemblyOfTheOrderView: View {
    @ObservedObject var viewModel = TabBarViewModel()
//    let screenSize = UIScreen.main.bounds
//    var screenWidth = screenSize.width
//    var screenHeight = screenSize.height

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    ZStack {
                        ZStack {
                            VStack(spacing: 100) {
                                Button {
                                    viewModel.viewState = .zero
                                } label: {
                                    Image(systemName: "x.circle")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                }
                                ZStack {
                                    Image(systemName: "cart")
                                        .resizable()
                                        .frame(width: 240, height: 240)
//                                        .padding(.top, 0)
                                        .foregroundColor(.green)
                                }
                            }
                        }
                        HStack {
                            VStack {

                                CustomImage(image: "apple", width1: 100, width2: 275, height1: 90, height2: 240)
                                CustomImage(image: "apricot", width1: 100, width2: 275, height1: 40, height2: 190)
                                CustomImage(image: "banana", width1: 100, width2: 275, height1: -30, height2: 110)
                                CustomImage(image: "kiwi", width1: 100, width2: 275, height1: -110, height2: 30)
                                CustomImage(image: "lemon", width1: 100, width2: 275, height1: -190, height2: -40)
                                    .padding(.horizontal)
                            }

                            Spacer()
                            VStack {
                                CustomImage(image: "mango", width1: -250, width2: -70, height1: 80, height2: 230)
                                CustomImage(image: "orange", width1: -250, width2: -60, height1: 30, height2: 190)
                                CustomImage(image: "peach", width1: -250, width2: -50, height1: -30, height2: 110)
                                CustomImage(image: "pear", width1: -250, width2: -60, height1: -110, height2: 30)
                                CustomImage(image: "pineapple", width1: -250, width2: -70, height1: -190, height2: -40)
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

//        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
    }
}

struct AssemblyOfTheOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AssemblyOfTheOrderView()
    }
}

struct CustomImage: View {
    @State var image: String
    @ObservedObject var viewModel = TabBarViewModel()
    @State var width1: CGFloat
    @State var width2: CGFloat
    @State var height1: CGFloat
    @State var height2: CGFloat
    var body: some View {
        Image(image)
            .resizable()
            .frame(width: 60, height: 60)
            .cornerRadius(30)
            .aspectRatio(contentMode: .fill)
            .padding(3)
            .background(.green)
            .clipShape(Circle())
//            .blendMode(.hardLight)
            .blur(radius: viewModel.show ? 1 : 0)
            //                            .background(show ? .red : .clear)
            .offset(x: viewModel.viewState.width, y: viewModel.viewState.height)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 1.2))
            .gesture(
                DragGesture().onChanged { value in
                    self.viewModel.viewState = value.translation
                    self.viewModel.show = true
                }
                .onEnded { _ in

                    if viewModel.viewState.width <= width1 || viewModel.viewState.width >= width2 {
                        self.viewModel.img = image
                        print("🥳---------")
                        print("\(viewModel.viewState.width)")
                        self.viewModel.viewState = .zero
                    }
                    if viewModel.viewState.height <= height1 || viewModel.viewState.height >= height2 {
                        self.viewModel.img = image
                        print("🥳---------")
                        print("\(viewModel.viewState.width)")
                        self.viewModel.viewState = .zero
                    }
//                    self.viewModel.viewState = .zero
                    self.viewModel.show = false
                }
            )
    }
}
