import Foundation
import SwiftUI

class TabBarViewModel: ObservableObject {
    @Published var fruit = [Fruit]()

    @Published var selected = 0

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @Published var show = false
    @Published var viewState: CGSize = .zero

   
}
