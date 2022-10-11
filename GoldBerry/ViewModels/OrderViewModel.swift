
import Foundation

class OrderViewModel: ObservableObject {
    let email = UserDefaults.standard.value(forKey: "userEmail")
    @Published var order = [Order]()
    @Published var fruitOrder = [Fruit]()
    @Published var orderNumber = 0
    @Published var count = 0
//    @Published var tog = false
//    @Published var tog1 = false
    @Published var price: Double? = 1
    @Published var image = ""
    
    @Published var show = false
    @Published var date = ""
    @Published var address = ""
////    @Published var price: Double = 0
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


//    func sendRequest(completion: @escaping (Bool) -> Void) {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
//            completion(self.tog == false)
//        }
//    }
    func dateFormatter() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy.HH.mm"
        self.date = dateFormatter.string(from: self.deliveryDate)
    }
    
}
