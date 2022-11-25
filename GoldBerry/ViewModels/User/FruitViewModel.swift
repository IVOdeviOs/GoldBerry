import Combine
import CoreData
import FirebaseAuth
import FirebaseFirestore
import Foundation
import SwiftUI
class FruitViewModel: ObservableObject {

    @Published var dictionaryOfNameAndCountOfFruits: [String: Double] = ["": 0]
    @Published var showCartCount = true

    @Published var selected = 0
    @Published var fruit = [Fruit]()
    @Published var favoriteFruits = [Fruit]()
    @Published var isLoading = false
    let email = UserDefaults.standard.value(forKey: "userEmail")

    @Published var uniqFruits = [Fruit]()
    @Published var isShowCount = false
    @Published var cost: Double = 1
    @Published var countCart = 0

    @Published var percent: Int? = 1

    @Published var isValid = true
    @Environment(\.managedObjectContext) private var viewContext

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
    @Published var showAuth = false
    @Published var alertFavorite = false
    @Published var show = false
    @Published var showAuthCartView = false
    @Published var viewState: CGSize = .zero
    @Published var presentedAuth = false
    @Published var arrayOfFruitPrice = [String: Double]()
    func sum() -> Double {
        var sumOfArray: Double = 0
        for price in arrayOfFruitPrice.values {
            sumOfArray += price
        }
        return sumOfArray
    }

    func deleteAllRecords() {
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "FruitEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)

        do {
            try viewContext.execute(deleteRequest)

            try viewContext.save()
        } catch {}
    }

    func fetchFruit() async throws {

        let urlString = Constants.baseURL + EndPoints.fruit
        isLoading = true

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let fruitResponse: [Fruit] = try await HttpClient.shared.fetch(url: url)

        DispatchQueue.main.async { [self] in
            self.fruit = fruitResponse
            self.isLoading = false
        }
    }
}
