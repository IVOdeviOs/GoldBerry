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

    var orders: [Order] = [
//        Order(
//            orderNumber: 1,
//            fruit: [watermelon, apple, apricot, banana],
//            date: "18/08/2022",
//            address: "Минск, пр-т Независимости, 10-23",
//            price: 1000
//        ),
//        Order(
//            orderNumber: 2,
//            fruit: [banana],
//            date: "19/08/2022",
//            address: "Минск, пр-т Независимости, 10-23",
//            price: 1000
//        )
    ]
    

    
}
