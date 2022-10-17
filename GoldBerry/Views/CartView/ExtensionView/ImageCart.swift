

//import SwiftUI
//
//struct CustomImage: View {
//    @State var image: String
//    @StateObject var viewModels : TabBarViewModel
//    @ObservedObject var viewModel = TabBarViewModel()
//    @State var width1: CGFloat
//    @State var width2: CGFloat
//    @State var height1: CGFloat
//    @State var height2: CGFloat
//    @State var index: Int
//
//    var body: some View {
//        Image(image)
//            .resizable()
//            .frame(width: 60, height: 60)
//            .cornerRadius(30)
//            .aspectRatio(contentMode: .fill)
//            .padding(3)
//            .background(.green)
//            .clipShape(Circle())
////            .blendMode(.hardLight)
//            .blur(radius: viewModel.show ? 1 : 0)
//            .offset(x: viewModel.viewState.width, y: viewModel.viewState.height)
//            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 1.2))
//            .gesture(
//                DragGesture().onChanged { value in
//                    self.viewModel.viewState = value.translation
//                    self.viewModel.show = true
//                }
//                .onEnded { _ in
//
//                    if (viewModel.viewState.width <= width1 || viewModel.viewState.width >= width2) || (viewModel.viewState.height <= height1 || viewModel.viewState.height >= height2) {
//                        self.viewModel.viewState = .zero
//                    } else {
//                    switch index {
//                    case 1:
//                        viewModels.fruit.append(Fruit(image: "watermelon", name: "12", cost: 1200, count: 12, weightOrPieces: "кг", favorite: false))
//                    case 2:
//                        viewModels.fruit.append(Fruit(image: "watermelon", name: "abricos", cost: 210, count: 21, weightOrPieces: "кг", favorite: false))
//                    case 3:
//                        viewModels.fruit.append(Fruit(image: "watermelon", name: "banana", cost: 2100, count: 21, weightOrPieces: "кг", favorite: false))
//                    case 4:
//                        print("\(viewModels.fruit.count)")
//                    case 5:
//                        print("5")
//                    case 6: print("6")
//                    case 7: print("7")
//                    case 8: print("8")
//                    case 9: print("9")
//                    case 10: print("10")
//                    default:
//                        break
//                    }
//                    }
//                        self.viewModel.show = false
//                    
//                }
//            )
//    }
//}
