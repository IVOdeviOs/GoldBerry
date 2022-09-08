import Foundation
import SwiftUI

struct Fruit: Identifiable, Codable {

   // var id = UUID().uuidString
   // var image: String
  //  var name: String
   // var description: String?
//    var cost: Double
//    var count: Int
//    var weightOrPieces: String
//    var favorite: Bool
//    var price: Double?
//    var percent: Int?
//    var categories: String?
//
    var id : UUID?
    var cost: Double
    var weightOrPieces, categories: String
    var favorite: Bool
    var count: Int
    var image: String
    var name: String
    var percent: Int?
    var description: String?
    var price: Double?
    
    var itog: Double {

        let per = Double(percent!)
        let del = (per / 100)
        let sa = 1 - del
        let sum = cost * sa

        return sum
    }
}

//struct Fruits:Identifiable, Codable {
//    var id : UUID?
//    var cost: Int
//    var weightOrPieces, categories: String
//    var favorite: Bool
//    var count: Int
//    var image: String
//    var name: String
//    var percent: Int
//}

//let watermelon = Fruit(id: "1", image: "watermelon", name: "Watermelon", cost: 1000, count: 1, weightOrPieces: "кг", favorite: false)
//let apple = Fruit(id: "2", image: "apple", name: "Apple", cost: 400, count: 1, weightOrPieces: "кг", favorite: false)
//let apricot = Fruit(id: "3", image: "apricot", name: "Apricot", cost: 550, count: 1, weightOrPieces: "кг", favorite: false)
//let banana = Fruit(id: "4", image: "banana", name: "Banana", cost: 1400, count: 1, weightOrPieces: "кг", favorite: false)
let order = Order(orderNumber: 1, date: "",fruit: [Fruit(cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1)] ,address: "", price: 1, customer: "", customerPhone: "", comment: "")


let watermelon = Fruit(cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1)
let apple = Fruit(cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1)
let apricot = Fruit(cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1)
let banana = Fruit(cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1)
