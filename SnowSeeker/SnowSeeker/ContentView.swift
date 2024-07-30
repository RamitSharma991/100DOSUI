//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Ramit Sharma on 26/07/24.
//

import SwiftUI

enum SortOrder: String, CaseIterable, Identifiable {
    case `default` = "Default"
    case alphabetical = "Alphabetical"
    case country = "Country"
    
    var id: String { self.rawValue}
    
}

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @State private var favorites = Favorites()
    @State private var sortOrder: SortOrder = .default
    @State private var showingSortOptions = false
    
    
    var filteredResorts: [Resort] {
        
        let sortedResorts: [Resort]
        switch sortOrder {
        case .default:
            sortedResorts = resorts
        case .alphabetical:
            sortedResorts = resorts.sorted { $0.name < $1.name }
        case .country:
            sortedResorts = resorts.sorted { $0.country < $1.country }
        }
        
        if searchText.isEmpty {
            //resorts
            return sortedResorts
        } else {
            // resorts.filter { $0.name.localizedStandardContains(searchText) }
            return sortedResorts.filter { $0.name.localizedStandardContains(searchText)}
        }
    }
    
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort.")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            .searchable(text: $searchText, prompt: "Search for a resort")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingSortOptions = true
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down.circle")
                    }
                    .tint(.secondary)
                    
                }
            }
            .actionSheet(isPresented: $showingSortOptions) {
                ActionSheet(title: Text("Sort Resorts"),
                    buttons: [
                        .default(Text("Default")) { sortOrder = .default },
                        .default(Text("Alphabetical")) { sortOrder = .alphabetical },
                        .default(Text("Country")) { sortOrder = .country },
                        .cancel()
                        
                    ]
                )
            }
        } detail: {
            WelcomeView()
        }
        .environment(favorites)
        
    }
}

#Preview {
    ContentView()
}
