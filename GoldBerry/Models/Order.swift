import Foundation

struct Order: Identifiable, Codable {
    var id: UUID?
    var orderNumber: String
    var date: String
    var dateOrder: String
    var email: String
    var fruit: [Fruit]
    var address: String
    var price: Double
    var customer, customerPhone, comment: String
    var orderCompleted: Bool
}
