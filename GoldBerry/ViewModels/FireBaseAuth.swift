import Combine
import Firebase
import FirebaseAuth
import Foundation
import SwiftUI

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
                $0.count >= 6 && $0 != "password"
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

func forGetPassword(email: String) {

    Auth.auth().sendPasswordReset(withEmail: email) { err in

        if err != nil {

            return
        }
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
