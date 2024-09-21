//
//  ContentView.swift
//  ShufflerGame
//
//  Created by Ramit Sharma on 16/09/24.
//

import SwiftUI

struct ShufflerGameVIew: View {
    let emojis = ["🏀", "🏓", "🎾", "⚽️", "🏏", "🏈", "🎳", "⚾️", "🏐", "⛳️", "🥊", "🏒"]
    
    @State var cardCount = 4
    
    var body: some View {
        VStack {
            ScrollView {
                cards
            }
            Spacer()
            cardCountAdjusters
        }
        .padding()
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85))]) {
            ForEach(emojis.indices, id: \.self) { index in
                CardView(content: emojis[index])
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.teal)
    }
    
    func cardCountAdjester(by offset: Int, symbol: String) -> some View {
        Button {
            if cardCount > 1 {
                cardCount -= 1

            }
        } label: {
            Image(systemName: symbol)
        }
        .disabled(cardCount + offset < 1 || cardCount + offset > emojis.count)

    }
    
    var cardRemover: some View {
        cardCountAdjester(by: -1, symbol: "rectangle.stack.minus.fill")
    }
    var cardAdder: some View {
        cardCountAdjester(by: +1, symbol: "rectangle.stack.plus.fill")
    }
    var cardCountAdjusters: some View {
        HStack {
            cardRemover
            Spacer()
            cardAdder
        }
        .imageScale(.large)
        .font(.largeTitle)
    }

}

struct CardView: View {
    let content: String
    @State var isFaceUp = false
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 15)
            
            Group {
                base.fill(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.largeTitle)
            }
            .opacity(isFaceUp ? 1 : 0)
            base.fill().opacity(isFaceUp ? 0 : 1)
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

#Preview {
    ShufflerGameVIew()
}
