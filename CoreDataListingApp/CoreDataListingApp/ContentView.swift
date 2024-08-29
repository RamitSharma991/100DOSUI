//
//  ContentView.swift
//  CoreDataListingApp
//
//  Created by Ramit Sharma on 23/08/24.
//

import SwiftUI

struct ContentView: View {

    var body: some View {
        NavigationStack {
            Home()
                .navigationTitle("Listings")
        }
    }
}

#Preview {
    ContentView()
}
