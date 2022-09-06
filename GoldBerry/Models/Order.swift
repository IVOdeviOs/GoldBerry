import Foundation

struct Order: Identifiable, Codable, Hashable {
    var id = UUID().uuidString
    var orderNumber: Int
    var fruit1 = [Fruit]()
    var fruit: Fruit?
    var date: String
    var address: String
    var price: Double
    var customer: String
    var customerPhone: String
    var comment: String

}
