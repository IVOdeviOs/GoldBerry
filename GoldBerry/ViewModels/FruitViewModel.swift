import CoreData
import FirebaseAuth
import Foundation
import SwiftUI
class FruitViewModel: ObservableObject {

//    @FetchRequest(entity: UserRegEntity.entity(), sortDescriptors: [])
//    var userss: FetchedResults<UserRegEntity>
    let email = UserDefaults.standard.value(forKey: "userEmail")

    @Published var showUserInfoView = false
    var userId: UUID?

    var isUpdating: Bool {
        userId != nil
    }

    @Published var userName = " "
    @Published var userSurname = " "
    @Published var userPhone = " "

    @Published var cost:Double = 1
    @Published var weightOrPieces = ""
    @Published var categories = ""
    @Published var favorite = true
    @Published var count = 1
    @Published var image = ""
    @Published var name = ""
    @Published var percent: Int? = 1
    @Published var descriptions: String? = ""
    @Published var price: Double? = 1
    @Published var comment: String? = ""
    var itog: Double {

        let per = Double(percent!)
        let del = (per / 100)
        let sa = 1 - del
        let sum = cost * sa

        return sum
    }

    init() {}
    init(currentUser: User) {
        self.userName = currentUser.userName
        self.userSurname = currentUser.userSurname
        self.userPhone = currentUser.userPhone
//        self.userId = currentUser.id
    }

//    @Published var fru: Fruit = Fruit(cost: 1, weightOrPieces: "", categories: "", favorite: false, count: 1, image: "", name: "")

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    @Published var show = false
    @Published var userRegShow = false
    @Published var viewState: CGSize = .zero

    @Published var fruit = [Fruit]()
    @Published var fruitOrder = [Fruit]()

    @Published var selected = 0
    @Published var orderNumber = 0
    @Published var order = [Order]()
    @Published var users =
        User(
            userName: "",
            userSurname: "",
            userPhone: "",
            userEmail: ""
        )
    @Published var user = [User]()

    @Published var date = ""
    @Published var address = ""
//    @Published var price: Double = 0
    @Published var customer = ""
    @Published var customerPhone = ""
    @Published var comments = ""
    @Published var favouriteProducts: [Fruit] = [
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
    ]
    func updateUser() async throws {
        let urlString = Constants.baseURL + EndPoints.user

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let usersId = UserDefaults.standard.value(forKey: email as! String)

        let userToUpdate = User(id: usersId as! UUID, userName: userName, userSurname: userSurname, userPhone: userPhone, userEmail: email as! String)

        try await HttpClient.shared.sendData(to: url, object: userToUpdate, httpMethod: HttpMethods.PUT.rawValue)
    }

//    func addUpdateAction(completion: @escaping () -> Void) {
//        Task {
//            do {
//                if isUpdating {
//                    try await updateUser()
//                } else {
//
//                    try await addUser()
//                }
//            } catch {
//
//                print("🤣")
//            }
//            completion()
//        }
//    }

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

    func fetchFruit() async throws {
        let urlString = Constants.baseURL + EndPoints.fruit

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let fruitResponse: [Fruit] = try await HttpClient.shared.fetch(url: url)

        DispatchQueue.main.async { [self] in
            self.fruit = fruitResponse
           
        }
    }

    func fetchUser() async throws {
        let urlString = Constants.baseURL + EndPoints.user

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let userResponse: [User] = try await HttpClient.shared.fetch(url: url)

        DispatchQueue.main.async {
            self.user = userResponse
        }
    }

    func addUser() async throws {
        let urlString = Constants.baseURL + EndPoints.user

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }

        let user = User(userName: userName, userSurname: userSurname, userPhone: userPhone, userEmail: email as! String)

        UserDefaults.standard.set(user.id, forKey: email as! String)

        try await HttpClient.shared.sendData(to: url, object: user, httpMethod: HttpMethods.POST.rawValue)
    }
//
//    func deleteUser(at offSets: IndexSet) {
//        offSets.forEach { i in
//            guard let userId = user[i].id else {
//                return
//            }
//            guard let url = URL(string: Constants.baseURL + EndPoints.user + "/\(userId)") else {
//                return
//            }
//            Task {
//                do {
//                    try await HttpClient.shared.delete(at: userId, url: url)
//                } catch {
//                    print("🤣 error \(error)")
//                }
//            }
//        }
//
//        user.remove(atOffsets: offSets)
//    }
}
