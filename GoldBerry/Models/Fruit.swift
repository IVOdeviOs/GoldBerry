import Foundation

struct Fruit: Identifiable {
    var id = UUID().uuidString

    var name: String
    var cost: String
    var count: Int
}
