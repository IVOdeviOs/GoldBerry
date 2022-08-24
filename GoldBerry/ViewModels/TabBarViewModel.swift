import Foundation
import SwiftUI

class TabBarViewModel: ObservableObject {
    @Published var fruit = [Fruit]()

    @Published var selected = 0

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @Published var show = false
    @Published var viewState: CGSize = .zero

    func fetchFruit() async throws {
        let urlString = Constants.baseURL + EndPoints.songs

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let fruitResponse: [Fruit] = try await HttpClient.shared.fetch(url: url)

        DispatchQueue.main.async {
            self.fruit = fruitResponse
        }
    }
}
