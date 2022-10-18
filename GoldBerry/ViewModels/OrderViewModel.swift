import Combine
import Foundation

class OrderViewModel: ObservableObject {
    let email = UserDefaults.standard.value(forKey: "userEmail")
    @Published var id = UUID().uuidString
    @Published var order = [Order]()
    @Published var fruitOrder = [Fruit]()
    @Published var orderNumber = 0
    @Published var count = 0
    @Published var price: Double? = 1
    @Published var image = ""
    @Published var show = false
    @Published var date = ""
    @Published var dateOrder = ""

    @Published var address = ""

    @Published var customer = ""
    @Published var customerPhone = ""
    @Published var comments = ""
    @Published var deliveryDate = Date()
    @Published var isValid = false

    var cancellable: Set<AnyCancellable> = []

//    private var formattedEmailPublisher: AnyPublisher<String, Never> {
//        $customer
//            .map { $0.lowercased() }
//            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
//            .eraseToAnyPublisher()
//    }

    private var isDateValidPublisher: AnyPublisher<Bool, Never> {
        $date
            .map {
                $0.count > 2
            }
            .replaceNil(with: false)
            .eraseToAnyPublisher()
    }

    private var isCustomerValidPublisher: AnyPublisher<Bool, Never> {
        $customer
            .map {
                $0.count > 2
            }
            .replaceNil(with: false)
            .eraseToAnyPublisher()
    }

    private var isCustomerPhoneValidPublisher: AnyPublisher<Bool, Never> {
        $customerPhone
            .map {
                let regex =  "((375|80)(25|29|33|34)([0-9]{3}([0-9]{2}){2}))"
                let predicate = NSPredicate(format:"SELF MATCHES %@",regex)
                let result = predicate.evaluate(with: $0)
                return result
            }
            .eraseToAnyPublisher()
    }

    private var isAddressValidPublisher: AnyPublisher<Bool, Never> {
        $address
            .map {
                $0.count > 2
            }
            .eraseToAnyPublisher()
    }

    var isFormValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isCustomerValidPublisher,
                                  isDateValidPublisher,
                                  isCustomerPhoneValidPublisher,
                                  isAddressValidPublisher)
            .map { $0.0 && $0.1 && $0.2 && $0.3 }
            .eraseToAnyPublisher()
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

    func addOrder(orders: Order) async throws {
        let urlString = Constants.baseURL + EndPoints.order

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let order = orders
        try await HttpClient.shared.sendData(to: url, object: order, httpMethod: HttpMethods.POST.rawValue)
    }

    func dateFormatter() {
        let dateFormatterOrder = DateFormatter()
        dateFormatterOrder.dateFormat = "dd.MM.yyyy.HH.mm"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        date = dateFormatter.string(from: deliveryDate)
        dateOrder = dateFormatterOrder.string(from: .now)
    }

}
