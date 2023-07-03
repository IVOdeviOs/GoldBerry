import Firebase
import FirebaseAuth
import NotificationCenter
import SwiftUI
@main
struct GoldBerryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    let persistenceController = PersistenceController.shared

    @ObservedObject var adminViewModel = AdminViewModel()
    var body: some Scene {
        WindowGroup {
            ContentView(adminViewModel: adminViewModel)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(\.locale, .init(identifier: Locale.current.identifier))
        }
    }
}

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()

        Messaging.messaging().delegate = self
  

        UNUserNotificationCenter.current().delegate = self

        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )

        application.registerForRemoteNotifications()


        return true
    }
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication
//                         .LaunchOptionsKey: Any]?) -> Bool
//    {
////        FirebaseApp.configure()
////
////        Messaging.messaging().delegate = self
////
////
////        UNUserNotificationCenter.current().delegate = self
////
////        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
////        UNUserNotificationCenter.current().requestAuthorization(
////            options: authOptions,
////            completionHandler: { _, _ in }
////        )
////
////        application.registerForRemoteNotifications()
////
////
////        return true
//    }

    func application(_ application: UIApplication,
                     didReceiveRemoteNotification userInfo: [AnyHashable: Any]) async
        -> UIBackgroundFetchResult
    {
     
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }

     

        return UIBackgroundFetchResult.newData
    }

    func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {

    }
    // [END receive_message]

    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print("☢️Unable to register for remote notifications: \(error.localizedDescription)")
    }

    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        Messaging.messaging().apnsToken = deviceToken
        print("🛑APNs token retrieved: \(deviceToken)")

//         Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().isAutoInitEnabled = true
    }
}


extension AppDelegate: UNUserNotificationCenterDelegate {
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification) async
//        -> UNNotificationPresentationOptions
//    {
//        let userInfo = notification.request.content.userInfo
//
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//
//        print(userInfo)
//
//        return [[.badge, .banner, .sound]]
//    }

//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                didReceive response: UNNotificationResponse) async
//    {
//        let userInfo = response.notification.request.content.userInfo
//
//
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
//
//        print(userInfo)
//    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
      withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      let userInfo = notification.request.content.userInfo

      Messaging.messaging().appDidReceiveMessage(userInfo)

      // Change this to your preferred presentation option
        completionHandler([[.badge,.banner, .sound]])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
      let userInfo = response.notification.request.content.userInfo

      Messaging.messaging().appDidReceiveMessage(userInfo)

      completionHandler()
    }

}


extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        
         let dataDict: [String: String] = ["token": fcmToken ?? ""]
         NotificationCenter.default.post(
           name: Notification.Name("FCMToken"),
           object: nil,
           userInfo: dataDict
         )
        print(dataDict)
    }

}
