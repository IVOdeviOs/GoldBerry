import CoreData
import FirebaseAuth
import Foundation
import SwiftUI

class UserViewModel: ObservableObject {

    let emails = UserDefaults.standard.value(forKey: "userEmail")

    var numberPhone = "+375336096300"
   
    @Published var alert = false
    @Published var countOrder = 0
    @Published var showUserInfoView = false
    @Published var showServiceInfoView = false
    @Published var showShopView = false
    @Published var showFavouriteProductsView = false

    @Published var userRegShow = false
    @Published var user = [User]()
    @Published var userName = " "
    @Published var userSurname = " "
    @Published var userPhone = " "

    @Published var favouriteProducts: [Fruit] = []
    
    func updateUser() async throws {
        let urlString = Constants.baseURL + EndPoints.user

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let usersId = UserDefaults.standard.value(forKey: emails as! String)

        let userToUpdate = User(id: usersId as! UUID, userName: userName, userSurname: userSurname, userPhone: userPhone, userEmail: emails as! String)

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
    
    //    var userId: UUID?
    //
    //    var isUpdating: Bool {
    //        userId != nil
    //    }
       

    //    init() {}
    //    init(currentUser: User) {
    //        self.userName = currentUser.userName
    //        self.userSurname = currentUser.userSurname
    //        self.userPhone = currentUser.userPhone
    ////        self.userId = currentUser.id
    //    }

}
