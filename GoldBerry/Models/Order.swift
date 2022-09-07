import Foundation

//struct Order: Identifiable, Codable, Hashable {
//    var id = UUID().uuidString
//    var orderNumber: Int
//    var fruit1 = [Fruit]()
//    var fruit: Fruit?
//    var date: String
//    var address: String
//    var price: Double
//    var customer: String
//    var customerPhone: String
//    var comment: String
//
//}

struct Order:Identifiable, Codable {
    var id : UUID?
    var orderNumber: Int
    var date: String
    var fruit: [Fruits]
    var address: String
    var price: Int
    var customer, customerPhone, comment: String

}

struct Fruits:Identifiable, Codable {
    var id : UUID?
    var cost: Int
    var weightOrPieces, categories: String
    var favorite: Bool
    var count: Int
    var image: String
    var name: String
    var percent: Int
}
