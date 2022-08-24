import Foundation
import SwiftUI

struct Fruit: Identifiable,Codable {

    var id = UUID().uuidString
    var image: String
    var name: String
    var cost: Int
    var count: Int
    var  weightOrPieces: String
}


let watermelon: Fruit = Fruit(id: "1", image: "watermelon", name: "Watermelon", cost: 1000, count: 1, weightOrPieces: "кг")
let apple: Fruit = Fruit(id: "2", image: "apple", name: "Apple", cost: 400, count: 2, weightOrPieces: "кг")
let apricot: Fruit = Fruit(id: "3", image: "apricot", name: "Apricot", cost: 550, count: 1, weightOrPieces: "кг")
let banana: Fruit = Fruit(id: "4", image: "banana", name: "Banana", cost: 1400, count: 5, weightOrPieces: "кг")
