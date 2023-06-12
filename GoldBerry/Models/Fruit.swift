import Foundation
import SwiftUI

struct Fruit: Identifiable, Codable, Hashable {

    var id: UUID?
    var cost: Double
    var weightOrPieces, categories: String
    var favorite: Bool
    var count: Double
    var image: String
    var name: String
    var percent: Int
    var price: Double?
    var comment: String
    var stepCount: Double
    var costs: Double {
        var currents: Double = 1
        if Locale.current.identifier == "en_US" {
            currents = 2.95
        }

        let sum = cost / currents

        return sum
    }

    var itog: Double {
        var currents: Double = 1
        if Locale.current.identifier == "en_US" {
            currents = 2.95
        }

        let per = Double(percent)
        let del = (per / 100)
        let sa = 1 - del
        let sum = cost * sa / currents

        return sum
    }

    var isValid: Bool?
}
