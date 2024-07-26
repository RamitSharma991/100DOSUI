//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Ramit Sharma on 26/07/24.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Text("Welcome to snowSeeker!")
            .font(.largeTitle)
        Text("Please select a resort from the left-hand menu; swipe from the left edge to show it")
            .foregroundStyle(.secondary)
    }
}

#Preview {
    WelcomeView()
}
