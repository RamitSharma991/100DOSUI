//
//  HotProspectsApp.swift
//  HotProspects
//
//  Created by Ramit Sharma on 31/05/24.
//

import SwiftUI
import SwiftData

@main
struct HotProspectsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Prospect.self)
    }
}
