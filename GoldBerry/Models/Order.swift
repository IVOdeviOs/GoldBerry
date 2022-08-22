import Foundation

struct Order: Identifiable {
    var id = UUID().uuidString
    var orderNumber: Int
    var fruit = [Fruit]()
    var date: String
    var address: String
    var price: Double
    var customer: String
    var customerPhone: String
}
