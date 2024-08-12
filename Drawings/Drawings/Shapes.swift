//
//  Shapes.swift
//  Drawings
//
//  Created by Ramit Sharma on 09/08/24.
//

import SwiftUI

struct Shapes: View {
    @State private var thickness: CGFloat = 20
    @State private var arrowHeadHeight: CGFloat = 50
    
    
    var body: some View {
        VStack {
            Arrow(thickness: thickness, arrowHeadHeight: arrowHeadHeight)
                .fill(Gradient(colors: [.blue, .pink]))
                .frame(width: 100, height: 200)
                .onTapGesture {
                    withAnimation {
                        thickness = thickness == 20 ? 40 : 20
                        arrowHeadHeight = arrowHeadHeight == 50 ? 80 : 50
                    }
                    
                }
        }
        
        Text("Tap the arrow to animate")
            .font(.headline)
            .padding()
            .foregroundColor(.clear) // Make the text color clear
            .overlay(
                LinearGradient(gradient: Gradient(colors: [.red, .orange, .yellow, .green, .blue]),
                               startPoint: .leading, endPoint: .trailing)
                .mask(
                    Text("Tap the Arrow to animate")
                        .fontWeight(.bold)
                )
            )
    }
}

struct Arrow: Shape {
    var thickness: CGFloat
    var arrowHeadHeight: CGFloat
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get {
            AnimatablePair(thickness, arrowHeadHeight)
        }
        set {
            thickness = newValue.first
            arrowHeadHeight = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let shaftHeight = rect.height - arrowHeadHeight
        let shaftWidth = thickness
        let shaftX = (rect.width - shaftWidth) / 2
        let arrowHeadBaseY = shaftHeight
        let arrowHeadTipY = rect.height

        
        path.addRect(CGRect(x: shaftX, y: 0, width: shaftWidth, height: shaftHeight))
        
        path.move(to: CGPoint(x: 0, y: arrowHeadBaseY))
        path.addLine(to: CGPoint(x: rect.width / 2, y: arrowHeadTipY))
        path.addLine(to: CGPoint(x: rect.width, y: arrowHeadTipY))
        path.closeSubpath()
        

        
        return path
    }
}


#Preview {
    Shapes()
}
