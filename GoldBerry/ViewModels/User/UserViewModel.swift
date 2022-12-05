import CoreData
import FirebaseAuth
import Foundation
import SwiftUI

class UserViewModel: ObservableObject {

    let emails = UserDefaults.standard.value(forKey: "userEmail")
    let nameKey = "nameKey"
    let surNameKey = "surNameKey"
    let numberPhoneKey = "numberPhoneKey"
    var numberPhone = "+375297023701"

    @Published var alert = false
    @Published var alertDeleted = false

    @Published var countOrder = 0
    @Published var showUserInfoView = false
    @Published var showServiceInfoView = false
    @Published var showShopView = false
    @Published var showFavouriteProductsView = false

    @Published var userRegShow = false
    @Published var user = [User]()
//    @Published var userAuth = [LoginUser]()
    @Published var userName = ""
    @Published var userSurname = ""
    @Published var userPhone = ""

    @Published var favouriteProducts: [Fruit] = []

    func deleteSong(id: UUID ) {
             
            guard let url = URL(string: Constants.baseURL + EndPoints.user + "/\(id)") else {
                return
            }
            Task {
                do {
                    try await HttpClient.shared.delete(at: id, url: url)
                } catch {
                }
            }
        
        
    }
}
