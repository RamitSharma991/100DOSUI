//
//  ContentView.swift
//  Drawings
//
//  Created by Ramit Sharma on 08/08/24.
//

import SwiftUI

struct Spirograph: Shape {
    let innerRadius: Int
    let outerRadius: Int
    let distance: Int
    let amount: Double
    
    func gcd(_ a: Int, _ b: Int) -> Int {
        var a = a
        var b = b
        
        while b != 0 {
            let temp = b
            b = a % b
            a = temp
        }
        
        return a
    }
    
    func path(in rect: CGRect) -> Path {
        let divisor = gcd(innerRadius, outerRadius)
        let outerRadius = Double(self.outerRadius)
        let innerRadius = Double(self.innerRadius)
        let distance = Double(self.distance)
        let difference = innerRadius - outerRadius
        let endPoint = ceil(2 * Double.pi * outerRadius / Double(divisor)) * amount
        
        var path = Path()
        
        
        for theta in stride(from: 0, through: endPoint, by: 0.1) {
            var x = difference * cos(theta) + distance * cos(difference / outerRadius * theta)
            var y = difference * sin(theta) - distance * sin(difference / outerRadius * theta)
            
            x += rect.width / 2
            y += rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        return path
    }
}

struct CycloidView: Shape {
    let radius: Double
    let amount: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let endPoint = amount * 2 * Double.pi * radius
        
        for theta in stride(from: 0, through: endPoint, by: 0.1) {
            let x = radius * (theta - sin(theta))
            let y = radius * (1 - cos(theta))
            
            let pointX = x + rect.width / 2
            let pointY = y + rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: pointX, y: pointY))
            } else {
                path.addLine(to: CGPoint(x: pointX, y: pointY))
            }
        }
        
        return path
    }
}

struct EpicycloidView: Shape {
    let innerRadius: Double
    let outerRadius: Double
    let amount: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let r = innerRadius
        let R = outerRadius
        let k = R / r
        let endPoint = amount * 2 * Double.pi
        
        for theta in stride(from: 0, through: endPoint, by: 0.1) {
            let x = (R + r) * cos(theta) - r * cos((R + r) / r * theta)
            let y = (R + r) * sin(theta) - r * sin((R + r) / r * theta)
            
            let pointX = x + rect.width / 2
            let pointY = y + rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: pointX, y: pointY))
            } else {
                path.addLine(to: CGPoint(x: pointX, y: pointY))
            }
        }
        
        return path
    }
}

struct HypotrochoidsView: Shape {
    let innerRadius: Double
    let outerRadius: Double
    let distance: Double
    let amount: Double
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let r = innerRadius
        let R = outerRadius
        let d = distance
        let endPoint = amount * 2 * Double.pi
        
        for theta in stride(from: 0, through: endPoint, by: 0.1) {
            let x = (R - r) * cos(theta) + d * cos((R - r) / r * theta)
            let y = (R - r) * sin(theta) - d * sin((R - r) / r * theta)
            
            let pointX = x + rect.width / 2
            let pointY = y + rect.height / 2
            
            if theta == 0 {
                path.move(to: CGPoint(x: pointX, y: pointY))
            } else {
                path.addLine(to: CGPoint(x: pointX, y: pointY))
            }
        }
        
        return path
    }
}


struct ContentView: View {
    @State private var innerRadius = 125.0
    @State private var outerRadius = 75.0
    @State private var radius = 5.0
    @State private var distance = 25.0
    @State private var amount = 1.0
    @State private var hue = 0.6
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer()
                    TabView {
                        Spirograph(innerRadius: Int(innerRadius), outerRadius: Int(outerRadius), distance: Int(distance), amount: amount)
                            .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                            .frame(width: 300, height: 300)
                            .tabItem {
                                Text("Spirograph")
                            }
                        
                        HypotrochoidsView(innerRadius: innerRadius, outerRadius: outerRadius, distance: distance, amount: amount)
                            .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                            .frame(width: 300, height: 300)
                            .tabItem {
                                Text("Hypotrochoids")
                            }
                        
                        CycloidView(radius: radius, amount: amount)
                            .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                            .frame(width: 300, height: 300)
                            .tabItem {
                                Text("Zykloide")
                            }
                        
                        EpicycloidView(innerRadius: innerRadius, outerRadius: outerRadius, amount: amount)
                            .stroke(Color(hue: hue, saturation: 1, brightness: 1), lineWidth: 1)
                            .frame(width: 300, height: 300)
                            .tabItem {
                                Text("Epizykloiden")
                            }
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .automatic))
                    .frame(width: 400, height: 400)
                    
                    
                    
                    Spacer()
                    
                    Group {
                        Text("Inner radius: \(Int(innerRadius))")
                        Slider(value: $innerRadius, in: 10...150, step: 1)
                            .padding([.horizontal, .bottom])
                        Text("Outer radius: \(Int(outerRadius))")
                        Slider(value: $outerRadius, in: 10...150, step: 1)
                            .padding([.horizontal, .bottom])
                        Text("Distance: \(Int(distance))")
                        Slider(value: $distance, in: 1...150, step: 1)
                            .padding([.horizontal, .bottom])
                        Text("Amount: \(Int(amount))")
                        Slider(value: $amount)
                            .padding([.horizontal, .bottom])
                        Text("Color")
                        Slider(value: $hue)
                            .padding(.horizontal)
                    }
                    
                    NavigationLink(destination: Shapes()) {
                        Text("Go to Shapes")
                            .font(.headline)
                            .padding()
                            .background(Gradient(colors: [.blue, .pink]))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                    NavigationLink(destination: ColorCyclingView()) {
                        Text("Go to ColorCycle")
                            .font(.headline)
                            .padding()
                            .background(Gradient(colors: [.purple, .teal]))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top)
                    
                }
            }
        }
        .navigationTitle("Spirograph")
    }
}

#Preview {
    ContentView()
}
