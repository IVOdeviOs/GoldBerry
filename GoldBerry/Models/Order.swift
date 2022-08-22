import Foundation

class Order: ObservableObject, Identifiable {
    @Published var orderNumber: Int
    @Published var fruit = [Fruit]()
    @Published var date: String = ""
    @Published var address: String = ""
    @Published var price: Double = 10.00
    @Published var customer: String = ""
    @Published var customerPhone: String = ""
    
    init(
        orderNumber: Int,
        fruit: [Fruit],
        date: String,
        address: String,
        price: Double,
        customer: String,
        customerPhone: String
    ) {
        self.orderNumber = orderNumber
        self.fruit = fruit
        self.date = date
        self.address = address
        self.price = price
        self.customer = customer
        self.customerPhone = customerPhone
    }
}

