import Foundation
import SwiftUI

struct Fruit: Identifiable {
    var id = UUID().uuidString

    var imageName: String
    var name: String
    var cost: String
    var count: Int
}

let watermelon: Fruit = Fruit(id: "1", imageName: "watermelon", name: "Watermelon", cost: "1000", count: 1)
let apple: Fruit = Fruit(id: "2", imageName: "apple", name: "Apple", cost: "400", count: 2)
let apricot: Fruit = Fruit(id: "3", imageName: "apricot", name: "Apricot", cost: "550", count: 1)
let banana: Fruit = Fruit(id: "4", imageName: "banana", name: "Banana", cost: "1400", count: 5)
