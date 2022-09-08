//
//import CoreData
//
//struct PersistenceController {
//    static let shared = PersistenceController()
//
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        for _ in 0..<10 {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//        }
//        do {
//            try viewContext.save()
//        } catch {
//            // Replace this implementation with code to handle the error appropriately.
//            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//
//    let container: NSPersistentContainer
//
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "GoldBerry")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//              
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        container.viewContext.automaticallyMergesChangesFromParent = true
//    }
//}
////final class CoreDataManager {
////    // MARK: - Properties
////
////    // MARK: Private
////
////    static let instance = CoreDataManager()
////
////    // MARK: - Commands
////
////
////
////    func saveFruit(_ fruit: Fruit) {
////        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
////
////        let managerContext = appDelegate.persistentContainer.viewContext
////
////        let entity = NSEntityDescription.entity(forEntityName: "PersonEntity", in: managerContext)!
////
////        let person = NSManagedObject(entity: entity, insertInto: managerContext)
////
////
//////        person.setValue(user.name, forKey: "name")
//////        person.setValue(user.surName, forKey: "surName")
//////        person.setValue(user.phoneNumber, forKey: "phoneNumber")
//////        person.setValue(user.phonePrefix, forKey: "phonePrefix")
//////        person.setValue(user.image, forKey: "image")
////        do {
////            try managerContext.save()
////        } catch let error as NSError {
////            print("error- \(error)")
////        }
////    }
////
////    func getPerson() -> [UserSettings]? {
////        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return nil }
////
////        let managerContext = appDelegate.persistentContainer.viewContext
////
////        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonEntity")
////
////        do {
////            let object = try managerContext.fetch(fetchRequest)
////            var users = [UserSettings]()
////            for object in object {
////                guard let name = object.value(forKey: "name") as? String,
////                      let surName = object.value(forKey: "surName") as? String,
////                      let phoneNumber = object.value(forKey: "phoneNumber") as? String,
////                      let phonePrefix = object.value(forKey: "phonePrefix") as? String,
////                      let image = object.value(forKey: "image") as? String else { return nil }
////                let user = UserSettings(name: name, surName: surName, phoneNumber: phoneNumber, phonePrefix: phonePrefix, image: image)
////                users.append(user)
////
////            }
////            return users
////        } catch let error as NSError {
////            print("Error-\(error)")
////        }
////        return nil
////    }
////
////    func deleteAllPerson(_ users: [UserSettings]) {
////        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate
////        else { return }
////
////        let managedContext = appDelegate.persistentContainer.viewContext
////
////        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "PersonEntity")
////
////        if let users = try? managedContext.fetch(fetchRequest) {
////            for user in users {
////                managedContext.delete(user)
////            }
////        }
////        do {
////            try managedContext.save()
////        } catch let error as NSError {
////            print("Error - \(error)")
////        }
////    }
////
////    private init() {}
////}
