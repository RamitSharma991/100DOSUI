//
//  CoreDataListingAppApp.swift
//  CoreDataListingApp
//
//  Created by Ramit Sharma on 23/08/24.
//

import SwiftUI

@main
struct CoreDataListingAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
