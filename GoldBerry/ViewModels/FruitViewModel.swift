import Foundation
import SwiftUI
import CoreData

class FruitViewModel: ObservableObject {
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @Published var show = false
    @Published var viewState: CGSize = .zero
    @Published var fruit = [Fruit]()
    @Published var selected = 0
    @Published var orderNumber = 0
    @Published var order = [Order]()
    @Published var user: User =
    User(
        userName: "",
        userSurname: "",
        userPhone: "",
        userEmail: ""
    )

    @Published var date = ""
    @Published var address = ""
    @Published var price: Double = 0
    @Published var customer = ""
    @Published var customerPhone = ""
    @Published var comment = ""
    @Published var favouriteProducts: [Fruit] = [
//    Fruit(
//        cost: 5.60,
//        weightOrPieces: "1 kg",
//        categories: "Fruits",
//        favorite: true,
//        count: 1,
//        image: "apple",
//        name: "Apple"
//    ),
//    Fruit(
//        cost: 1.50,
//        weightOrPieces: "1 kg",
//        categories: "Fruits",
//        favorite: true,
//        count: 1,
//        image: "watermelon",
//        name: "Watermelon"
//    )
    ]
    
    func fetchOrder() async throws {
        let urlString = Constants.baseURL + EndPoints.order

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let orderResponse: [Order] = try await HttpClient.shared.fetch(url: url)

        DispatchQueue.main.async {
            self.order = orderResponse
        }
    }

    func addOrder(orders:Order) async throws {
        let urlString = Constants.baseURL + EndPoints.order

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let order = orders
        try await HttpClient.shared.sendData(to: url, object: order, httpMethod: HttpMethods.POST.rawValue)
    }

    func fetchFruit() async throws {
        let urlString = Constants.baseURL + EndPoints.fruit

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let fruitResponse: [Fruit] = try await HttpClient.shared.fetch(url: url)

        DispatchQueue.main.async {
            self.fruit = fruitResponse
        }
    }
}
