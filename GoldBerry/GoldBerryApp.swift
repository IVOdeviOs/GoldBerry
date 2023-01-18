import Firebase
import FirebaseAuth
import SwiftUI

@main
struct GoldBerryApp: App {
    let persistenceController = PersistenceController.shared
    init() {
        FirebaseApp.configure()
    }

    @ObservedObject var adminViewModel = AdminViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(adminViewModel: adminViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.locale, .init(identifier: adminViewModel.language ))
        }
    }
}
