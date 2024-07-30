//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Ramit Sharma on 26/07/24.
//

import SwiftUI

@Observable
class Favorites {
    private var resorts: Set<String>
    private let key = "Favorites"
    
    init() {
        // load saved data with Userdefaults.
        if let savedResorts = UserDefaults.standard.object(forKey: key) as? [String] {
            resorts = Set(savedResorts)
        } else {
            resorts = []
        }
        
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // save data with userdefaults.
        UserDefaults.standard.set(Array(resorts), forKey: key)
    }
    
}
