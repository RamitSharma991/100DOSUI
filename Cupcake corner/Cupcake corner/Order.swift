//
//  Order.swift
//  Cupcake corner
//
//  Created by Ramit sharma on 16/04/24.
//

import Foundation

@Observable
class Order: Codable {
    
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _name = "name"
        case _city = "city"
        case _streetAddress = "streetAddress"
        case _zip = "zip"
        case _addSprinkes = "addSprinkes"
        
    }
    
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkes = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkes = false
    
    var name = ""
    var streetAddress = ""
    
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        return true
    }
    
    var cost: Double {
        var cost = Double(quantity) * 2 // 2 per cake
        cost += (Double(type) / 2) // more cost
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        return cost
    }
}
