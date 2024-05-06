//
//  SwiftDataProjectApp.swift
//  SwiftDataProject
//
//  Created by Ramit Sharma on 06/05/24.
//

import SwiftUI
import SwiftData


@main
struct SwiftDataProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)

    }
}
