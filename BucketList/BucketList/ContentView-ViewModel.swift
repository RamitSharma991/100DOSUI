//
//  ContentView-ViewModel.swift
//  BucketList
//
//  Created by Ramit Sharma on 21/05/24.
//


import CoreLocation
import Foundation
import LocalAuthentication

extension ContentView {
    @Observable
    class ViewModel {
        let savePath = URL.documentsDirectory.appending(path: "SavedPlaces")
        private(set) var locations: [Location]
        var selectedPlace: Location?
        var isUnlocked = false
 
        init() {
            do {
                let data = try Data(contentsOf: savePath)
                locations = try JSONDecoder().decode([Location].self, from: data)
            } catch {
                locations = []
            }
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(locations)
                try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
        
        func addLocation(at point: CLLocationCoordinate2D) {
            let newLocation = Location(id: UUID(), name: "New location", description: "", latitude: point.latitude, longitude: point.longitude)
            locations.append(newLocation)
        }
        
        func removeLocation(at point: CLLocationCoordinate2D) {
            if let index = locations.firstIndex(where: {$0.id == selectedPlace?.id } ) {
                locations.remove(at: index)
            }
            
        }
            
        func update(location: Location) {
            guard let selectedPlace else { return }
            
            if let index = locations.firstIndex(of: selectedPlace) {
                locations[index] = location
            }
        }
        
        func authenticate() {
            let context = LAContext()
            var error: NSError?
            
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
                let reason = "Please authenticate yourself to unlock your places."
                
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                    
                    if success {
                        self.isUnlocked = true
                    } else {
                        // error
                        self.isUnlocked = false
                    }
                }
            } else {
                print("No biometric")
                // no biometrics
            }
        }
    }
}
