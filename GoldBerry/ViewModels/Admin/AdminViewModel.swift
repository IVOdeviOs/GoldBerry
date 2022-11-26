import Combine
import Foundation
import SwiftUI

class AdminViewModel: ObservableObject {
    @Published var order = [Order]()
    @Published var showAddFruit = false
    @Published var deleteFruit = false
    @Published var selected = 0
    @Published var fruit = [Fruit]()
    @Published var isLoading = false
   
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
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

    func addFruit(fruits: Fruit) async throws {
        let urlString = Constants.baseURL + EndPoints.fruit

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let fruit = fruits
        try await HttpClient.shared.sendData(to: url, object: fruit, httpMethod: HttpMethods.POST.rawValue)
    }
    
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

    func deleteFruit(id: UUID?) async throws {
        guard let userId = id else {
            return
        }

        guard let url = URL(string: Constants.baseURL + EndPoints.fruit + "/\(userId)") else {
            return
        }
        Task {
            do {
                try await HttpClient.shared.delete(at: userId, url: url)
            } catch {
                print("🤣 error \(error)")
            }
        }
    }
}



//func deleteOrder(id: UUID?) async throws {
//    guard let userId = id else {
//        return
//    }
//
//    guard let url = URL(string: Constants.baseURL + EndPoints.order + "/\(userId)") else {
//        return
//    }
//    Task {
//        do {
//            try await HttpClient.shared.delete(at: userId, url: url)
//        } catch {
//            print("🤣 error \(error)")
//        }
//    }
//}
