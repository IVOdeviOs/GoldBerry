import Foundation

class OrderViewModel: ObservableObject {

    @Published var orderNumber = 0
    @Published var fruit = [Fruit]()

    @Published var order = [Order]()
    

    @Published var date = ""
    @Published var address = ""
    @Published var price: Double = 0
    @Published var customer = ""
    @Published var customerPhone = ""
    @Published var comment = ""

    @Published var orders: [Order] = [
        Order(
            orderNumber: 1,
            fruit1: [watermelon, apple, apricot, banana],
            date: "18/08/2022",
            address: "Минск, пр-т Независимости, 10-23",
            price: 1000,
            customer: "Oleg",
            customerPhone: "+375-29-777-11-11",
            comment: "ss"
        ),
        Order(
            orderNumber: 2,
            fruit1: [banana],
            date: "19/08/2022",
            address: "Минск, пр-т Независимости, 10-23",
            price: 1000,
            customer: "Oleg",
            customerPhone: "+375-29-777-11-11",
            comment: "sss"
        )
    ]

    @Published var order1 = Order(
        orderNumber: 1,
        fruit1: [watermelon, apple, apricot, banana],
        date: "",
        address: "",
        price: 0,
        customer: "",
        customerPhone: "",
        comment: ""
    )

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

    func addOrder() async throws {
        let urlString = Constants.baseURL + EndPoints.order

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let order = Order( orderNumber: orderNumber, fruit1: [watermelon, apple] , date: date, address: address, price: Double(Int(Double(Int(price)))), customer: customer, customerPhone: customerPhone, comment: comment)

        try await HttpClient.shared.sendData(to: url, object: order, httpMethod: HttpMethods.POST.rawValue)
    }
}
