//
//  Resort.swift
//  SnowSeeker
//
//  Created by Ramit Sharma on 26/07/24.
//

import Foundation

struct Resort: Codable, Hashable, Identifiable {
    var id: String
    var name: String
    var country: String
    var description: String
    var imageCredit: String
    var price: Int
    var size: Int
    var snowDepth: Int
    var elevation: Int
    var runs: Int
    var facilities: [String]
    
    var FacilityTypes: [Facility] {
        facilities.map(Facility.init)
    }
    
    static let allResorts: [Resort] = Bundle.main.decode("resort.json")
    static let example = allResorts[0]
    //    static let example = (Bundle.main.decode("resort.json") as [Resort])[0]
    
}
