
import Foundation

class OrderViewModel: ObservableObject {
    let email = UserDefaults.standard.value(forKey: "userEmail")
    @Published var order = [Order]()
    @Published var fruitOrder = [Fruit]()
    @Published var orderNumber = 0
    @Published var count = 0
    @Published var price: Double? = 1
    @Published var image = ""
    @Published var show = false
    @Published var date = ""
    @Published var address = ""

    @Published var customer = ""
    @Published var customerPhone = ""
    @Published var comments = ""
    @Published var deliveryDate = Date()

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

    func addOrder(orders: Order) async throws {
        let urlString = Constants.baseURL + EndPoints.order

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let order = orders
        try await HttpClient.shared.sendData(to: url, object: order, httpMethod: HttpMethods.POST.rawValue)
    }

    func dateFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
        date = dateFormatter.string(from: deliveryDate)
    }

//    var cancellable: Set<AnyCancellable> = []
//
//    private var formattedEmailPublisher: AnyPublisher<String, Never> {
//        $customer
//            .map {
//                $0.count > 8 && $0 != "password"
//            }
//            .eraseToAnyPublisher()
//    }
}
