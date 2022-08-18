import Foundation

class Order: ObservableObject, Identifiable {
    @Published var orderNumber: Int
    @Published var fruit = [Fruit]()
    @Published var date: String = ""
    @Published var address: String = ""
    @Published var price: Double = 10.00
    
    init(orderNumber: Int, fruit: [Fruit], date: String, address: String, price: Double) {
        self.orderNumber = orderNumber
        self.fruit = fruit
        self.date = date
        self.address = address
        self.price = price
    }
}

