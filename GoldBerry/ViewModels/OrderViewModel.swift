import Foundation

class OrderViewModel: ObservableObject {
    
    @Published var orderNumber: Int = 0
    @Published var fruit = [Fruit]()
    @Published var date: String = ""
    @Published var address: String = ""
    @Published var price: Double = 0
    @Published var customer: String = ""
    @Published var customerPhone: String = ""
    
   @Published var orders: [Order] = [
        Order(
            orderNumber: 1,
            fruit: [watermelon, apple, apricot, banana],
            date: "18/08/2022",
            address: "Минск, пр-т Независимости, 10-23",
            price: 1000,
            customer: "Oleg",
            customerPhone: "+375-29-777-11-11"
        ),
        Order(
            orderNumber: 2,
            fruit: [banana],
            date: "19/08/2022",
            address: "Минск, пр-т Независимости, 10-23",
            price: 1000,
            customer: "Oleg",
            customerPhone: "+375-29-777-11-11"
        )
    ]
}
