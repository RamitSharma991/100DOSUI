//
//  ContentView.swift
//  BrainyGame
//
//  Created by Ramit sharma on 06/03/24.
//

import SwiftUI

struct ContentView: View {
    @State private var moves = ["🪨", "📄", "✂️"].shuffled()
    @State private var appsMoveIndex = Int.random(in: 0..<3)
    @State private var shouldPlayerWin = Bool.random()
    @State private var score = 0
    @State private var showScore = false
    @State private var rounds = 1
    
    let maxRounds = 10
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.teal, Color.blue, Color.purple, Color.pink]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                Text("Rock, Paper or Scissor")
                    .font(.title.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 10) {
                    VStack {
                        Text("Round \(rounds) / \(maxRounds)")
                        
                        Text("Apps Move")
                            .font(.headline.bold())
                            .foregroundStyle(.primary)
                        Text(moves[appsMoveIndex])
                            .font(.system(size: 200))
                        
                    }
                    
                    VStack(spacing: 10) {
                        Text("Pick for a \(shouldPlayerWin ? "Win" : "Loss")")
                            .font(.title2)
                        
                        HStack(spacing: 20) {
                            ForEach(0..<3) { pick in
                                Button(moves[pick]) {
                                    play(pick)
                                }
                                .font(.system(size: 80))
                                .background(.ultraThinMaterial)
                                .cornerRadius(10)
                                
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                
                Spacer()
                Spacer()
                
                VStack(spacing: 5) {
                    Text("Score: \(score)")
                }
                .font(.headline.bold())
                .frame(width: 200, height: 100)
                .background(.ultraThinMaterial)
                .cornerRadius(20)
                
            }
            .padding()
            
        }
        .alert(isPresented: $showScore) {
            Alert(title: Text("Game Over"),
                  message: Text("Your final score is \(score)"), dismissButton: .default(Text("OK")))
        }
    }
    
    func play(_ pick: Int) {
        if shouldPlayerWin {
            if (appsMoveIndex == 0 && pick == 1) || (appsMoveIndex == 1 && pick == 2) || (appsMoveIndex == 2 && pick == 0) {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if (appsMoveIndex == 0 && pick == 2) || (appsMoveIndex == 1 && pick == 0) || (appsMoveIndex == 2 && pick == 1) {
                score += 1
            } else {
                score -= 1
            }
        }
        
        if rounds < maxRounds {
            rounds += 1
            appsMoveIndex = Int.random(in: 0..<3)
            shouldPlayerWin.toggle()
        } else {
            showScore = true
        }
    }
}



#Preview {
    ContentView()
}
