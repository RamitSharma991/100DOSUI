//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Ramit sharma on 26/04/24.
//

import SwiftUI
import SwiftData

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
