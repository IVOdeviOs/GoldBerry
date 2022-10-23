import CoreData
import FirebaseAuth
import Foundation
import SwiftUI

class UserViewModel: ObservableObject {

    let emails = UserDefaults.standard.value(forKey: "userEmail")
    let nameKey = "nameKey"
    let surNameKey = "surNameKey"
    let numberPhoneKey = "numberPhoneKey"
    var numberPhone = "+375336096300"

    @Published var alert = false
    @Published var alertDeleted = false

    @Published var countOrder = 0
    @Published var showUserInfoView = false
    @Published var showServiceInfoView = false
    @Published var showShopView = false
    @Published var showFavouriteProductsView = false

    @Published var userRegShow = false
    @Published var user = [User]()
    @Published var userName = ""
    @Published var userSurname = ""
    @Published var userPhone = ""

    @Published var favouriteProducts: [Fruit] = []

    func updateUser() async throws {
        let urlString = Constants.baseURL + EndPoints.user

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let usersId = UserDefaults.standard.value(forKey: emails as! String)

        let userToUpdate = User(id: usersId as? UUID, userName: userName, userSurname: userSurname, userPhone: userPhone, userEmail: emails as! String)

        try await HttpClient.shared.sendData(to: url, object: userToUpdate, httpMethod: HttpMethods.PUT.rawValue)
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

        let user = User(userName: userName, userSurname: userSurname, userPhone: userPhone, userEmail: emails as! String)

        UserDefaults.standard.set(user.id, forKey: emails as! String)

        try await HttpClient.shared.sendData(to: url, object: user, httpMethod: HttpMethods.POST.rawValue)
    }
}
