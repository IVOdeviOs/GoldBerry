import SwiftUI

struct AssemblyOfTheOrderView: View {
    @ObservedObject var viewModel = TabBarViewModel()
    @State var fruit: [Fruit] = []
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
                                    LinearGradient(gradient: Gradient(colors: [.green, .green.opacity(0.8), .orange]), startPoint: .top, endPoint: .bottom)
                                        .mask(Image(systemName: "cart")
                                            .resizable()
                                            .frame(width: 240, height: 240))
                                        .frame(width: 240, height: 240)
                                }
                            }
                        }
                        HStack {
                            VStack {

                                CustomImage(image: "apple", width1: 100, width2: 275, height1: 90, height2: 240, index: 1)
                                CustomImage(image: "apricot", width1: 100, width2: 275, height1: 40, height2: 190, index: 2)
                                CustomImage(image: "banana", width1: 100, width2: 275, height1: -30, height2: 110, index: 3)
                                CustomImage(image: "kiwi", width1: 100, width2: 275, height1: -110, height2: 30, index: 4)
                                CustomImage(image: "lemon", width1: 100, width2: 275, height1: -190, height2: -40, index: 5)
                                    .padding(.horizontal)
                            }

                            Spacer()
                            VStack {
                                CustomImage(image: "mango", width1: -250, width2: -70, height1: 80, height2: 230, index: 6)
                                CustomImage(image: "orange", width1: -250, width2: -60, height1: 30, height2: 190, index: 7)
                                CustomImage(image: "peach", width1: -250, width2: -50, height1: -30, height2: 110, index: 8)
                                CustomImage(image: "pear", width1: -250, width2: -60, height1: -110, height2: 30, index: 9)
                                CustomImage(image: "pineapple", width1: -250, width2: -70, height1: -190, height2: -40, index: 10)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
                Divider()
                Spacer()
                VStack {
                    ForEach(fruit) { fruit in
                        FruitListCell(name: fruit.name, cost: fruit.cost, count: fruit.count)
                    }
                }
            }
        }
        .offset(y: -70)
        .navigationBarHidden(true)
    }
}

struct AssemblyOfTheOrderView_Previews: PreviewProvider {
    static var previews: some View {
        AssemblyOfTheOrderView()
    }
}
