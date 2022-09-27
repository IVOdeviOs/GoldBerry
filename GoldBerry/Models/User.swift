import Foundation

struct User: Identifiable, Codable {
    var id : UUID?
    var userName, userSurname, userPhone, userEmail: String
 
}
