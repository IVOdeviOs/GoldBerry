import SwiftUI

struct FruitView: View {
    @ObservedObject var fruitViewModel: FruitViewModel
    @ObservedObject var orderViewModel: OrderViewModel

    var body: some View {

        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: fruitViewModel.columns, alignment: .center, spacing: 0, pinnedViews: .sectionFooters) {
                            ForEach(fruitViewModel.fruit) { fruits in
                                ProductViewCell(fruit: fruits, fruitViewModel: fruitViewModel)
                                    .padding(.bottom, 30)
                            }

                        }.padding(.bottom, 60)
                            .accessibilityElement()
                    }
                }
                .isLoading(fruitViewModel.isLoading)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .padding(.top, 40)
    }
}
