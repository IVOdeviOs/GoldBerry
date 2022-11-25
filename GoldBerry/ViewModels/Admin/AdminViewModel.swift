import Combine
import Foundation

class AdminViewModel: ObservableObject {
    @Published var order = [Order]()

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

    func deleteOrder(id: UUID?) async throws {
        guard let userId = id else {
        return
        }
        
        guard let url = URL(string: Constants.baseURL + EndPoints.order + "/\(userId)") else {
            return
        }
        Task {
            do {
                try await HttpClient.shared.delete(at: userId , url: url)
            } catch {
                print("🤣 error \(error)")
            }
        }
    }
}
