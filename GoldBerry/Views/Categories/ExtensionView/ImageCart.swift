import SwiftUI

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
            .offset(x: viewModel.viewState.width, y: viewModel.viewState.height)
            .animation(.timingCurve(0.2, 0.8, 0.2, 1, duration: 1.2))
            .gesture(
                DragGesture().onChanged { value in
                    self.viewModel.viewState = value.translation
                    self.viewModel.show = true
                }
                .onEnded { _ in

                    if (viewModel.viewState.width <= width1 || viewModel.viewState.width >= width2) || (viewModel.viewState.height <= height1 || viewModel.viewState.height >= height2) {
                        self.viewModel.viewState = .zero
                    }

                    self.viewModel.show = false
                }
            )
    }
}
