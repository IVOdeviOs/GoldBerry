import SwiftUI

struct FruitView: View {
    @ObservedObject var adminViewModel: AdminViewModel

    var body: some View {

        VStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack {
                    LazyVGrid(columns: adminViewModel.columns, alignment: .center, spacing: 0, pinnedViews: .sectionFooters) {
                        ForEach(adminViewModel.fruit, id: \.id) { fruits in

                            ProductViewCell(fruit: fruits, adminViewModel: adminViewModel)
                                .padding(.bottom, 35)
                        }

                    }.padding(.bottom, 95)
                        .accessibilityElement()
                }
            }
            .isLoading(adminViewModel.isLoading)
        }
        .padding(.top, 20)
    }
}
