import Foundation
import SwiftUI

struct Fruit: Identifiable, Codable, Hashable {

    var id: UUID?
    var cost: Double
    var weightOrPieces, categories: String
    var favorite: Bool
    var count: Int 
    var image: String
    var name: String
    var percent: Int
    var price: Double?
    var comment: String
    var itog: Double {

        let per = Double(percent)
        let del = (per / 100)
        let sa = 1 - del
        let sum = cost * sa

        return sum
    }

    var isValid: Bool?
}
