//import Firebase
//import FirebaseAuth
//
//func auth(){
//    let credential = PhoneAuthProvider.provider().credential(
//      withVerificationID: verificationID,
//      verificationCode: verificationCode
//    )
//    
//    Auth.auth().signIn(with: credential) { authResult, error in
//        if let error = error {
//          let authError = error as NSError
//          if isMFAEnabled, authError.code == AuthErrorCode.secondFactorRequired.rawValue {
//            // The user is a multi-factor user. Second factor challenge is required.
//            let resolver = authError
//              .userInfo[AuthErrorUserInfoMultiFactorResolverKey] as! MultiFactorResolver
//            var displayNameString = ""
//            for tmpFactorInfo in resolver.hints {
//              displayNameString += tmpFactorInfo.displayName ?? ""
//              displayNameString += " "
//            }
//            self.showTextInputPrompt(
//              withMessage: "Select factor to sign in\n\(displayNameString)",
//              completionBlock: { userPressedOK, displayName in
//                var selectedHint: PhoneMultiFactorInfo?
//                for tmpFactorInfo in resolver.hints {
//                  if displayName == tmpFactorInfo.displayName {
//                    selectedHint = tmpFactorInfo as? PhoneMultiFactorInfo
//                  }
//                }
//                PhoneAuthProvider.provider()
//                  .verifyPhoneNumber(with: selectedHint!, uiDelegate: nil,
//                                     multiFactorSession: resolver
//                                       .session) { verificationID, error in
//                    if error != nil {
//                      print(
//                        "Multi factor start sign in failed. Error: \(error.debugDescription)"
//                      )
//                    } else {
//                      self.showTextInputPrompt(
//                        withMessage: "Verification code for \(selectedHint?.displayName ?? "")",
//                        completionBlock: { userPressedOK, verificationCode in
//                          let credential: PhoneAuthCredential? = PhoneAuthProvider.provider()
//                            .credential(withVerificationID: verificationID!,
//                                        verificationCode: verificationCode!)
//                          let assertion: MultiFactorAssertion? = PhoneMultiFactorGenerator
//                            .assertion(with: credential!)
//                          resolver.resolveSignIn(with: assertion!) { authResult, error in
//                            if error != nil {
//                              print(
//                                "Multi factor finanlize sign in failed. Error: \(error.debugDescription)"
//                              )
//                            } else {
//                              self.navigationController?.popViewController(animated: true)
//                            }
//                          }
//                        }
//                      )
//                    }
//                  }
//              }
//            )
//          } else {
//            self.showMessagePrompt(error.localizedDescription)
//            return
//          }
//          // ...
//          return
//        }
//        // User is signed in
//        // ...
//    }
//    
//    
//    
//}

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
