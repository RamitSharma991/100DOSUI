//
//  ContentView.swift
//  BucketList
//
//  Created by Ramit Sharma on 17/05/24.
//

import MapKit
import SwiftUI

struct ContentView: View {
    @State private var viewModel = ViewModel()
    @State private var mapType: MKMapType = .standard
    @State private var showingAuthenticationFailedAlert = false
    @State private var authenticationErrorMessage = ""
    
    @Environment(\.dismiss) var dismiss
    
    
    let startPosition = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 56, longitude: -3),
            span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        )
    )
    
    var body: some View {
        VStack {
            if viewModel.isUnlocked {
                VStack {
                    Picker("Map Type", selection: $mapType) {
                        Text("Standard").tag(MKMapType.standard)
                        Text("Hybrid").tag(MKMapType.hybrid)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(10)
                    
                }
                MapReader { proxy in
                    Map(initialPosition: startPosition) {
                        ForEach(viewModel.locations) { location in
                            Annotation(location.name, coordinate: location.coordinate) {
                                Image(systemName: "star.circle")
                                    .resizable()
                                    .foregroundStyle(.red)
                                    .frame(width: 44, height: 44)
                                    .background(.white)
                                    .clipShape(.circle)
                                    .onLongPressGesture {
                                        viewModel.selectedPlace = location
                                    }
                                    .contextMenu {
                                        Button("Add Place") {
                                            viewModel.selectedPlace = location
                                        }
                                        Button("Remove Place") {
                                            if let selectedLocation = viewModel.selectedPlace {
                                                viewModel.removeLocation(at: selectedLocation.coordinate)
                                            }
                                        }
                                    }
                            }
                        }
                    }
                    .mapStyle(mapType == .standard ? .standard : .hybrid)
                    .onTapGesture { position in
                        if let coordinate = proxy.convert(position, from: .local) {
                            viewModel.addLocation(at: coordinate)
                        }
                    }
                    .sheet(item: $viewModel.selectedPlace) { place in
                        EditView(location: place) {
                            viewModel.update(location: $0)
                        }
                    }
                }
            } else {
                Button("Unlock Places", action: viewModel.authenticate)
                    .padding()
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
            }
        }
        .alert("Authentication Failed", isPresented: $showingAuthenticationFailedAlert) {
            Button("Ok", role: .cancel) {}
        } message: {
            Text(authenticationErrorMessage)
        }
    }
    
}

#Preview {
    ContentView()
}

