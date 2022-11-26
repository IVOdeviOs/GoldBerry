import SwiftUI

struct FruitView: View {
    @ObservedObject var adminViewModel: AdminViewModel

    var body: some View {

        NavigationView {
            VStack {
                ScrollView(.vertical, showsIndicators: false) {
                    VStack {
                        LazyVGrid(columns: adminViewModel.columns, alignment: .center, spacing: 0, pinnedViews: .sectionFooters) {
                            ForEach(adminViewModel.fruit) { fruits in
                                ProductViewCell(fruit: fruits, adminViewModel: adminViewModel)
                                    .padding(.bottom, 30)
                            }

                        }.padding(.bottom, 60)
                            .accessibilityElement()
                    }
                }
                .isLoading(adminViewModel.isLoading)
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarHidden(true)
        }
        .padding(.top, 40)
    }
}
