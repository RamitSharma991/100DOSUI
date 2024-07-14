//
//  Card.swift
//  Flashzilla
//
//  Created by Ramit Sharma on 12/07/24.
//

import Foundation


struct Card: Codable, Identifiable {
    var prompt: String
    var answer: String
    var id = UUID()
    
    static let example = Card(prompt: "Who played the 13th Doctor Who?", answer: "Jode Whittaker")
}
