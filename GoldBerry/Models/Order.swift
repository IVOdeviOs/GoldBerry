import Foundation

struct Order: Identifiable, Codable {
    var id: UUID?
    var orderNumber: String
    var date: String
    var dateOrder: String
    var email: String
    var fruits: [Fruit]
    var address: String
    var price: Double
    var customer, customerPhone, comment: String
    var orderCompleted: Bool
    var prices: Double {
        var currents: Double = 1
        if Locale.current.identifier == "en_US" {
            currents = 2.64
        }
        let sum = price / currents

        return sum
    }
}
