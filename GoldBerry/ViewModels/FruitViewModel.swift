import Combine
import CoreData
import FirebaseAuth
import Foundation
import SwiftUI
class FruitViewModel: ObservableObject {

    
    @Published var dictionaryOfNameAndCountOfFruits: [String : Int] = ["" : 0]
    @Published var showCartCount = true
    
    @Published var selected = 0
    @Published var fruit = [Fruit]()
    @Published var isLoading = false
    let email = UserDefaults.standard.value(forKey: "userEmail")

    @Published var uniqFruits = [Fruit]()
    @Published var isShowCount = false
    @Published var cost: Double = 1
    @Published var countCart = 0

    @Published var percent: Int? = 1

    @Published var isValid = true
    @FetchRequest(entity: FruitEntity.entity(), sortDescriptors: [])
    var fruits: FetchedResults<FruitEntity>
    @Published var comment: String? = ""
    var itog: Double {

        let per = Double(percent!)
        let del = (per / 100)
        let sa = 1 - del
        let sum = cost * sa

        return sum
    }

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    @Published var show = false
    @Published var viewState: CGSize = .zero

    @Published var arrayOfFruitPrice = [String: Double]()
    func sum() -> Double {
        var sumOfArray: Double = 0
        for price in arrayOfFruitPrice.values {
            sumOfArray += price
        }
        return sumOfArray
    }

    @Published var favouriteProducts: [Fruit] = []

    func fetchFruit() async throws {
        self.isLoading = true
        let urlString = Constants.baseURL + EndPoints.fruit

        guard let url = URL(string: urlString) else {
            throw HttpError.badURL
        }
        let fruitResponse: [Fruit] = try await HttpClient.shared.fetch(url: url)

        DispatchQueue.main.async { [self] in
            self.isLoading = false
            self.fruit = fruitResponse
        }
    }

//    func fetchAllRestaurants() {
//        let db = Firestore.firestore()
//
//        db.collection("fruit").getDocuments { (querySnapshot, error) -> Void  in
//            if let error = error {
//                print("Error getting documents: \(error)")
//            } else {
////                self.fruit = querySnapshot!.documents.map({ d in
////                    print("\(d["name"])")
////                })
//
//                for document in querySnapshot!.documents {
//
//                    var f = Fruit(cost: document["cost"] as? Double ?? 1,
//                                  weightOrPieces: document["weightOrPieces"] as? String ?? "",
//                                  categories: document["categories"] as? String ?? "" ,
//                                  favorite: (document["favorite"] != nil),
//                                  count: document["count"] as? Int ?? 1,
//                                  image: document["image"] as? String ?? "",
//                                  name: document["name"] as? String ?? "",
//                                  percent: document["percent"] as? Int ?? 1,
//                                  comment: document["comment"] as? String ?? "",
//                                  isValid: true)
//                    return self.fruit.append(f)
////                    print("\(document.documentID): \(document["name"])")
//                }
//            }
//        }
//    }

//    func getData() {
//
//        let db = Firestore.firestore()
//
//        db.collection("fruit").getDocuments{ snapshot, error in
//
//            if error == nil {
//
//                if let snapshot = snapshot {
//
//                    DispatchQueue.main.async {
//
//                        self.fruit = snapshot.documents.map { d in
//
//                            // Create a Todo item for each document returned
//                          return  Fruit(cost: d["cost"],
//                                  weightOrPieces: d["weightOrPieces"],
//                                  categories: d["categories"],
//                                  favorite: d["favorite"],
//                                  count: d["count"],
//                                  image: d["image"],
//                                  name: d["name"],
//                                  percent: d["percent"],
//                                  price: 1,
//                                  comment: d["comment"],
//                                  isValid: false)
//                        }
//                    }
//                }
//            } else {
//                // Handle the error
//            }
//        }
//    }

//    func getData() {
//        var db = Firestore.firestore().collection("fruit")
//        db.getDocuments { snapshot, err in
//
    ////        }
    ////        db.collection("fruit").getDocuments { (snapshot,err) in
//
//            if err == nil {
//                if let snapshot = snapshot {
//
//                    DispatchQueue.main.async {
//                        self.fruit = snapshot.documents.map { d in
//                            Fruit(cost: d["cost"],
//                                  weightOrPieces: d["weightOrPieces"],
//                                  categories: d["categories"],
//                                  favorite: d["favorite"],
//                                  count: d["count"],
//                                  image: d["image"],
//                                  name: d["name"],
//                                  percent: d["percent"],
//                                  price: 1,
//                                  comment: d["comment"],
//                                  isValid: false)
//                        }
//                    }
//                }
//
//            } else {}
//        }
//    }
}
