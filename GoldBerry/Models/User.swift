import Foundation

struct User: Identifiable, Codable {
    var id: UUID?
    var userName, userSurname, userPhone, userEmail: String
}

struct LoginUser:Identifiable, Codable{
    var id: UUID?
    var login, password, role: String
    
}
