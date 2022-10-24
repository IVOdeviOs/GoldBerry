import Combine
import CoreData
import FirebaseAuth
import Foundation
import SwiftUI
class FruitViewModel: ObservableObject {

    @Published var showCartCount = true
    
    @Published var selected = 0
    @Published var fruit = [Fruit]()
    @Published var isLoading = false
    let email = UserDefaults.standard.value(forKey: "userEmail")

    @Published var uniqFruits = [Fruit]()
    @Published var isShowCount = false
    @Published var cost: Double = 1
    @Published var countCart = 0

    @Published var percent: Int? = 1

    @Published var isValid = true
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>
    @Published var comment: String? = ""
    var itog: Double {

        let per = Double(percent!)
        let del = (per / 100)
        let sa = 1 - del
        let sum = cost * sa

        return sum
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    @Published var show = false
    @Published var viewState: CGSize = .zero

    @Published var arrayOfFruitPrice = [String: Double]()
    func sum() -> Double {
        var sumOfArray: Double = 0
        for price in arrayOfFruitPrice.values {
            sumOfArray += price
        }
        return sumOfArray
    }

    @Published var favouriteProducts: [Fruit] = []

    func fetchFruit() async throws {
        self.isLoading = true
        let urlString = Constants.baseURL + EndPoints.fruit

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let fruitResponse: [Fruit] = try await HttpClient.shared.fetch(url: url)

        DispatchQueue.main.async { [self] in
            self.isLoading = false
            self.fruit = fruitResponse
        }
    }


   
}

