import Foundation
import SwiftUI

struct Fruit: Identifiable,Codable, Hashable {

    var id = UUID().uuidString
    var image: String
    var name: String
    var description: String
    var cost: Double
    var count: Int
    var  weightOrPieces: String
}


var watermelon: Fruit = Fruit(id: "1", image: "watermelon", name: "Watermelon", description: "Арбуз Краснодар, урожай 2022 года", cost: 1000, count: 1, weightOrPieces: "кг")
var apple: Fruit = Fruit(id: "2", image: "apple", name: "Apple", description: "Яблоко Беларусь, урожай 2022 года", cost: 400, count: 1, weightOrPieces: "кг")
var apricot: Fruit = Fruit(id: "3", image: "apricot", name: "Apricot", description: "Абрикос Турция, урожай 2022 года", cost: 550, count: 1, weightOrPieces: "кг")
var banana: Fruit = Fruit(id: "4", image: "banana", name: "Banana", description: "Банан Перу, урожай 2022 года", cost: 1400, count: 1, weightOrPieces: "кг")
