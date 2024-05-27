//
//  ContentView.swift
//  FlagQuiz
//
//  Created by Ramit sharma on 28/02/24.
//

import SwiftUI

struct Titles: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
            .shadow(color: .accentColor, radius: 0.2)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Titles())
    }
}

struct FlagImage: View {
    var imageName: String
    
    var body: some View {
        Image(imageName)
            .clipShape(Capsule())
            .shadow(radius: 10)
        
    }
}

struct ContentView: View {
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var score = 0
    @State private var gameReset = false
    @State private var timesTapped = 0
    
    @State private var animationAmount = 0.0
    @State private var changedOpacity = 1.0
    @State private var changedScale = 1.0
    
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
    
    
    var body: some View {
        
        ZStack {
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .titleStyle()
                
                VStack(spacing: 30) {
                    VStack(spacing: 10) {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.headline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .titleStyle()
                            .animation(.easeInOut(duration: 0.6))
                        
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            animationAmount += 360
                            flagTapped(number)
                            
                        } label: {
                            FlagImage(imageName: countries[number])
                        }
                        .rotation3DEffect(.degrees(number == correctAnswer ? animationAmount : 0), axis: (x: 0, y: 1, z: 0))
                        .opacity(number != correctAnswer ? changedOpacity : 1.0)
                        .scaleEffect(number != correctAnswer ? changedScale : 1.0)
                        .accessibilityLabel(labels[number])
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .animation(.spring(duration: 1, bounce: 0.2))
                
                Spacer()
                Spacer()
                
                VStack(spacing: 5) {
                    Text("Score: \(score)")
                    Text("Attempts: \(timesTapped)/8")
                }
                .foregroundStyle(.white)
                .font(.title.bold())
                .frame(width: 200, height: 100)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .animation(.easeInOut(duration: 0.6))
                
                Spacer()
                
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            if timesTapped < 8 {
                Button("Continue", action: askQuestion)
            }
            
            else {
                Button("Restart", action: reset)
            }
        } message: {
            Text("\(8 - timesTapped) attempts remaining")
        }
        
    }
    
    
    func flagTapped(_ number: Int) {
        
        timesTapped += 1
        if number == correctAnswer {
            scoreTitle = "Correct Answer! "
            score += 1
            
        }
        else {
            scoreTitle = """
            Wrong! ⚠️
            That's the flag of \(countries[number])
            """
            score -= 1
        }
        showingScore = true
        changedOpacity = 0.25
        changedScale = 0.70
        
        
    }
    
    func askQuestion() {
        if timesTapped < 8 {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
            changedOpacity = 1
            changedScale = 1
            
            
            
        } else {
            scoreTitle = "Game Resets after 8 attempts"
            showingScore = true
        }
    }
    
    func reset() {
        score = 0
        timesTapped = 0
        askQuestion()
    }
    
}

#Preview {
    ContentView()
}

