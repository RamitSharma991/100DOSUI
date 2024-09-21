//
//  ShufflerGameApp.swift
//  ShufflerGame
//
//  Created by Ramit Sharma on 16/09/24.
//

import SwiftUI

@main
struct ShufflerGameApp: App {
    @StateObject var game = ShufflerViewModel()
    
    var body: some Scene {
        WindowGroup {
            ShufflerGameView(viewModel: game)
        }
    }
}
