//
//  Color-Theme.swift
//  Moonshot
//
//  Created by Ramit sharma on 26/03/24.
//

import Foundation
import SwiftUI

extension ShapeStyle where Self == Color {
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
    }
    static var lightBackground: LinearGradient {
        LinearGradient(gradient: Gradient(colors: [Color.midPurple, Color.lightPurple, Color.darkPurple, Color.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
    }

}
