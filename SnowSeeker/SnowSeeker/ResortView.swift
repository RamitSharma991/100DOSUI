//
//  ResortView.swift
//  SnowSeeker
//
//  Created by Ramit Sharma on 26/07/24.
//

import SwiftUI

struct ResortView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    
    @State private var selectedFacility: Facility?
    @State private var showingFacility = false
    
    @Environment(Favorites.self) var favorites
    
    let backgroundGradient = LinearGradient(gradient: Gradient(colors: [.purple, .blue, .pink, .indigo]), startPoint: .topLeading, endPoint: .bottomTrailing)
    
    let resort: Resort
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                ZStack {
                    Image(decorative: resort.id)
                        .resizable()
                        .scaledToFit()
                    
                    Text("© \(resort.imageCredit)")
                        .font(.caption2.bold())
                        .foregroundColor(.white)
                        .padding(5)
                        .background(backgroundGradient.opacity(0.2))
                        .clipShape(Capsule())
                        .shadow(radius: 0.2)
                        .padding([.top, .leading], 5)
                    
                }
                
                HStack {
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge)
                
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    
                    Text("Facilities")
                        .font(.headline)
                    
                    //  Text(resort.facilities.joined(separator: ", "))
                    HStack {
                        ForEach(resort.FacilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                Button(favorites.contains(resort) ? "Remove from favorites" : "Add to favorites") {
                    if favorites.contains(resort){
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode((.inline))
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
            //
        } message: { facility in
            Text(facility.description)
            
        }
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
