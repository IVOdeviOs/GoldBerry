import Foundation

class OrderViewModel: ObservableObject {

    @Published var orderNumber = 0
    @Published var fruit = [Fruits]()

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
            date: "18/08/2022", fruit: [watermelon, apple, apricot, banana],
            address: "Минск, пр-т Независимости, 10-23",
            price: 1000,
            customer: "Oleg",
            customerPhone: "+375-29-777-11-11",
            comment: "ss"
        ),
        Order(
            orderNumber: 2,
            date: "19/08/2022", fruit: [banana],
            address: "Минск, пр-т Независимости, 10-23",
            price: 1000,
            customer: "Oleg",
            customerPhone: "+375-29-777-11-11",
            comment: "sss"
        )
    ]

    @Published var order1 = Order(
        orderNumber: 1,
        date: "", fruit: [watermelon, apple, apricot, banana],
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
        let order = Order(orderNumber: 1, date: "",fruit: [Fruits(cost: 1, weightOrPieces: "", categories: "", favorite: true, count: 1, image: "", name: "", percent: 1)] ,address: "", price: 1, customer: "", customerPhone: "", comment: "")
        try await HttpClient.shared.sendData(to: url, object: order, httpMethod: HttpMethods.POST.rawValue)
    }
}
