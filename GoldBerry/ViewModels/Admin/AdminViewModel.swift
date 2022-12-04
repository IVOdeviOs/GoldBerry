import Combine
import Foundation
import SwiftUI

class AdminViewModel: ObservableObject {
    @Published var order = [Order]()
    @Published var orderT = [Order]()

    @Published var showAddFruit = false
    @Published var showUpdate = false
    @Published var deleteFruit = false
    @Published var selected = 0
    @Published var fruit = [Fruit]()
    @Published var isLoading = false
    @Published var isUpdating = false
    @Published var showTabBar = false
    @Published var loginAdmin = ""
    @Published var passwordAdmin = ""
    @Published var statusAdmin = false
    @Published var message = ""

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    func fetchUser() async throws {
        let urlString = Constants.baseURL + EndPoints.adminOrder

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        var request = URLRequest(url: url)
        let loginString = String(format: "%@:%@", loginAdmin, passwordAdmin)
        let loginData = loginString.data(using: String.Encoding.utf8)!
        let base64LoginString = loginData.base64EncodedString()
        request.httpMethod = HttpMethods.GET.rawValue
        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: MIMEType.auth.rawValue)
        
        let (_, response) = try await URLSession.shared.data(for: request)
       
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
 
            throw HttpError.badResponse
        }
        statusAdmin.toggle()
  

    }
    
//    func sendData<T: Codable>(to url:URL, object: T, httpMethod: String) async throws {
//
//        var request = URLRequest(url: url)
//        let loginString = String(format: "%@:%@", loginAdmin, passwordAdmin)
//        let loginData = loginString.data(using: String.Encoding.utf8)!
//        let base64LoginString = loginData.base64EncodedString()
//
//        request.httpMethod = httpMethod
//        request.addValue("Basic \(base64LoginString)", forHTTPHeaderField: MIMEType.auth.rawValue)
//        request.addValue(MIMEType.JSON.rawValue, forHTTPHeaderField: HttpHeaders.contentType.rawValue)
//        request.httpBody = try? JSONEncoder().encode(object)
//
//        let (_, response) = try await URLSession.shared.data(for: request)
//        print("🏧\( statusAdmin)")
//        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
//            print("🏧\(HttpError.badResponse.localizedDescription)")
//            print("Вы не зарегистрированы как администратор")
//            throw HttpError.badResponse
//        }
//        statusAdmin.toggle()
//        print("🏧\( statusAdmin)")
//
//    }

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

    func updateFruit(fruit: Fruit) async throws {
        let urlString = Constants.baseURL + EndPoints.fruit

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let fruitToUpdate = fruit

        try await HttpClient.shared.sendData(to: url, object: fruitToUpdate, httpMethod: HttpMethods.PUT.rawValue)
    }
}

// func deleteOrder(id: UUID?) async throws {
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
// }
