//
//  GoldBerryApp.swift
//  GoldBerry
//
//  Created by Vadim on 02.08.2022.
//

import SwiftUI

@main
struct GoldBerryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
