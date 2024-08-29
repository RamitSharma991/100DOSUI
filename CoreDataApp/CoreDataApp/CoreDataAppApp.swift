//
//  CoreDataAppApp.swift
//  CoreDataApp
//
//  Created by Ramit Sharma on 22/08/24.
//

import SwiftUI

@main
struct CoreDataAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
