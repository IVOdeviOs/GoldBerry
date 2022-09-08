//import Foundation
//
//class OrderViewModel: ObservableObject {
//
//    @Published var orderNumber = 0
//    @Published var fruit = [Fruit]()
//    @Published var order = [Order]()
//    @Published var favouriteProducts: [Fruit] = [
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
//    ]
//
//    @Published var user: User =
//    User(
//        userName: "",
//        userSurname: "",
//        userPhone: "",
//        userEmail: ""
//    )
//    
//    @Published var date = ""
//    @Published var address = ""
//    @Published var price: Double = 0
//    @Published var customer = ""
//    @Published var customerPhone = ""
//    @Published var comment = ""
//
////    @Published var orders: [Order] = [
////        Order(
////            orderNumber: 1,
////            date: "18/08/2022", fruit: [watermelon, apple, apricot, banana],
////            address: "Минск, пр-т Независимости, 10-23",
////            price: 1000,
////            customer: "Oleg",
////            customerPhone: "+375-29-777-11-11",
////            comment: "ss"
////        ),
////        Order(
////            orderNumber: 2,
////            date: "19/08/2022", fruit: [banana],
////            address: "Минск, пр-т Независимости, 10-23",
////            price: 1000,
////            customer: "Oleg",
////            customerPhone: "+375-29-777-11-11",
////            comment: "sss"
////        )
////    ]
//
////    @Published var order1 = Order(
////        orderNumber: 1,
////        date: "", fruit: [watermelon, apple, apricot, banana],
////        address: "",
////        price: 0,
////        customer: "",
////        customerPhone: "",
////        comment: ""
////    )
//
//    func fetchOrder() async throws {
//        let urlString = Constants.baseURL + EndPoints.order
//
//        guard let url = URL(string: urlString) else {
//            throw HttpError.badURL
//        }
//        let orderResponse: [Order] = try await HttpClient.shared.fetch(url: url)
//
//        DispatchQueue.main.async {
//            self.order = orderResponse
//        }
//    }
//
//    func addOrder(orders:Order) async throws {
//        let urlString = Constants.baseURL + EndPoints.order
//
//        guard let url = URL(string: urlString) else {
//            throw HttpError.badURL
//        }
//        let order = orders
//        try await HttpClient.shared.sendData(to: url, object: order, httpMethod: HttpMethods.POST.rawValue)
//    }
//}
