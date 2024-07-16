//
//  ContentView.swift
//  Layout and geometry
//
//  Created by Ramit Sharma on 16/07/24.
//

import SwiftUI

struct ContentView: View {
    //    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]
    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { proxy in
                        
                        let minY = proxy.frame(in: .global).minY
                        let fullHeight = fullView.size.height
                        let opacity = calculateOpacity(for: minY, in: fullHeight)
                        let scale = calculateScale(for: minY, in: fullHeight)
                        let hue = calculateHue(for: minY, in: fullHeight)
                        
                        
                        Text("Row #\(index)")
                            .font(.title)
                            .frame(maxWidth: .infinity)
                        //                            .background(colors[index % 7])
                            .background(Color(hue: hue, saturation: 1, brightness: 1))
                            .rotation3DEffect(.degrees(proxy.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                            .opacity(opacity)
                            .scaleEffect(scale)
                    }
                    .frame(height: 40)
                }
            }
        }
    }
    
    func calculateOpacity(for minY: CGFloat, in fullHeight: CGFloat) -> Double {
        let threshold: CGFloat = 200
        if minY >= threshold {
            return 1.0
        } else {
            return Double(minY / threshold)
        }
    }
    
    func calculateScale(for minY: CGFloat, in fullHeight: CGFloat) -> CGFloat {
        let threshold: CGFloat = 200
        //        if minY >= fullHeight - threshold {
        //            return 1.0
        //        } else if minY <= threshold {
        //            return 0.5
        //        } else {
        //            return 0.5 + ((minY - threshold) / (fullHeight - 2 * threshold)) * 0.5
        //        }
        
        let scale = 0.5 + ((minY - threshold) / (fullHeight - 2 * threshold)) * 0.5
        return max(0.5, scale)
    }
    
    func calculateHue(for minY: CGFloat, in fullHeight: CGFloat) -> Double {
        let relativePostion = minY / fullHeight
        return min(Double(relativePostion), 1.0)
    }
}

#Preview {
    ContentView()
}
