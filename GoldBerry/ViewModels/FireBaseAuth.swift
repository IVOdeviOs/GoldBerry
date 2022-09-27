import Foundation
import Firebase
import FirebaseAuth
import SwiftUI
import Combine
import Foundation
import FirebaseCore

final class LogIn: ObservableObject {
    @Published var isLoading = false
    @Published var alert = false
    @Published var show = false
    @Published var message = ""
    @Published var index = 0

    @Published var email = ""
    @Published var password = ""
    @Published var confirmationPassword = ""
    @Published var terms = false
    @Published var isValid = false
    @Published var secure = true
    @Published var secureConfirm = true

    var cancellable: Set<AnyCancellable> = []

    private var formattedEmailPublisher: AnyPublisher<String, Never> {
        $email
            .map { $0.lowercased() }
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .eraseToAnyPublisher()
    }

    private var isEmailValidPublisher: AnyPublisher<Bool, Never> {
        formattedEmailPublisher
            .map {
                $0.contains("@") && $0.contains(".")
            }
            .replaceNil(with: false)
            .eraseToAnyPublisher()
    }

    private var isPasswordValidPublisher: AnyPublisher<Bool, Never> {
        $password
            .map {
                $0.count > 8 && $0 != "password"
            }
            .eraseToAnyPublisher()
    }

    private var isPasswordConfirmationValidPublisher: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest($password, $confirmationPassword)
            .map {
                $0.0 == $0.1
            }
            .eraseToAnyPublisher()
    }

    var isFormValid: AnyPublisher<Bool, Never> {
        Publishers.CombineLatest4(isEmailValidPublisher,
                                  isPasswordValidPublisher,
                                  isPasswordConfirmationValidPublisher,
                                  $terms)
            .map { $0.0 && $0.1 && $0.2 && $0.3 }
            .eraseToAnyPublisher()
    }
}

func signInWithEmail(email: String, password: String,
                     completion: @escaping (Bool, String) -> Void)
{

    Auth.auth().signIn(withEmail: email, password: password) { res, err in

        if err != nil {
            completion(false, (err?.localizedDescription)!)
            return
        }
        completion(true, (res?.user.email)!)
    }
}

func signUpWithEmail(email: String, password: String, confirmPassword: String,
                     completion: @escaping (Bool, String) -> Void)
{

    Auth.auth().createUser(withEmail: email, password: password) { res, err in

        if err != nil {
            completion(false, (err?.localizedDescription)!)
            return
        }
        completion(true, (res?.user.email)!)
    }
}

//let countries = [
//    "BY":"375",
//    "RU":"7"
//
//]
//
//
//class FireBaseLogin:ObservableObject{
//    @Published var phoneNumber = ""
//    @Published var code = ""
//
//    @Published var errorMSG = ""
//    @Published var error = false
//
//    @Published var CODE = ""
//    @Published var gotoVerify = false
//    @Published var loading = false
//    @AppStorage("log_status") var status = false
//
//    func getCountryCode()-> String{
//        let regioneCode = Locale.current.regionCode ?? ""
//
//        return countries[regioneCode] ?? ""
//    }
//
//
//    func sendCode(){
//
//
//
//        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
//
////        let number = "+\(getCountryCode())\(phoneNumber)"
//        let number = phoneNumber
//
//        PhoneAuthProvider.provider().verifyPhoneNumber(number, uiDelegate: nil) { (CODE,err) in
//            if let error = err{
//                self.errorMSG = error.localizedDescription
//                self.error.toggle()
//                return
//            }
//            self.CODE = CODE!
//            self.gotoVerify = true
//        }
//
//
//    }
//    func verifyCode(){
//        print("\(String(status))")
//
//        let credential = PhoneAuthProvider.provider().credential(withVerificationID: self.CODE, verificationCode: code)
//        loading = true
//        Auth.auth().signIn(with: credential){ (result,err) in
//            self.loading = false
//            print("\(String(self.status))")
//
//            if let error = err{
//                self.errorMSG = error.localizedDescription
//                self.error.toggle()
//                return
//            }
//            withAnimation{self.status = true}
//        }
//
//
//    }
//    func requestCode(){
//        sendCode()
//        withAnimation {
//            self.errorMSG = "Code sent Successfully "
//            self.error.toggle()
//        }
//
//
//    }
//
//
//}
