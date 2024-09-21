//
//  ShufflerViewModel.swift
//  ShufflerGame
//
//  Created by Ramit Sharma on 16/09/24.
//

import SwiftUI

class ShufflerViewModel: ObservableObject {
    
    static let sportsTheme = Theme(name: "Sports", emojis: ["🏀", "🏓", "🎾", "⚽️", "🏏", "🏈", "🎳", "⚾️", "🏐", "⛳️", "🥊", "🏒"], color: .pink, numberOfPairs: 12)
    static let animalsTheme = Theme(name: "Animals", emojis: ["🐶", "🐱", "🐭", "🦁", "🐷", "🐸", "🐵", "🐧", "🐼", "🦉", "🐙", "🦄"], color: .green, numberOfPairs: 12)
    static let halloweenTheme = Theme(name: "Halloween", emojis: ["🎃", "👻", "🕷", "🧙‍♀️", "🧛‍♂️", "🧟‍♂️", "🕸", "⚰️", "🍬", "🍫"], color: .orange, numberOfPairs: 10)
    static let fruitsTheme = Theme(name: "Fruits", emojis: ["🍎", "🍊", "🍇", "🍌", "🍍", "🍉", "🍓", "🍒", "🍑", "🥝", "🍈", "🍋"], color: .mint, numberOfPairs: 10)
    static let vehiclesTheme = Theme(name: "Vehicles", emojis: ["🚗", "🚕", "🚙", "🚌", "🚓", "🚑", "🚒", "🚜", "🚲", "🛵", "✈️", "🚀"], color: .red, numberOfPairs: 10)
    static let spaceTheme = Theme(name: "Space", emojis: ["🚀", "🛸", "🌕", "🪐", "🌌", "🌠", "👽", "🛰", "🪐", "⭐️", "☄️", "🌍"], color: .purple, numberOfPairs: 10)
    
    
    
    
    static let themes: [Theme] = [sportsTheme, animalsTheme, halloweenTheme, fruitsTheme, vehiclesTheme, spaceTheme]
    
    @Published private var model: ShufflerModel<String> = ShufflerViewModel.createMemoryGame(with: ShufflerViewModel.sportsTheme)
    @Published var score: Int = 0
    private var theme: Theme
    private var seenCards: Set<String> = []
    
    
    var themeColor: Color {
        theme.color
    }
    var themeName: String {
        theme.name
    }
    
    init(theme: Theme = sportsTheme) {
        self.theme = theme
        self.model = ShufflerViewModel.createMemoryGame(with: theme)
    }
    
    private static func createMemoryGame(with theme: Theme) -> ShufflerModel<String> {
        return ShufflerModel(numberOfPairsOfCards: theme.numberOfPairs) { pairIndex in
            if theme.selectedEmojis.indices.contains(pairIndex) {
                return theme.selectedEmojis[pairIndex]
            } else {
                return "⁉️"
            }
        }
    }
    
    var cards: Array<ShufflerModel<String>.Card> {
        return model.cards
    }
    
    func choose(_ card: ShufflerModel<String>.Card) {
        if let matchIndex = model.solitaryFaceUpCard, let selectedIndex = model.cards.firstIndex(of: card){
            if model.cards[matchIndex].content == model.cards[selectedIndex].content {
                score += 5
            } else {
                if cardHasBeenSeen(card) {
                    score -= 1
                }
                seenCards.insert(card.id)
            }
        }
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
        score = 0
        seenCards.removeAll()
    }
    
    func changeTheme(to newTheme: Theme) {
        self.theme = newTheme
        model = ShufflerViewModel.createMemoryGame(with: newTheme)
        score = 0
        seenCards.removeAll()
    }
    
    private func checkForMatch(_ card: ShufflerModel<String>.Card) -> Bool {
        if let matchIndex = model.solitaryFaceUpCard, let selectedIndex = model.cards.firstIndex(of: card) {
            return model.cards[matchIndex].content == model.cards[selectedIndex].content
        }
        return false
    }
    
    private func cardHasBeenSeen(_ card: ShufflerModel<String>.Card) -> Bool {
        return seenCards.contains(card.id)
    }
}

struct Theme {
    let name: String
    let emojis: [String]
    let color: Color
    let numberOfPairs: Int
    
    var selectedEmojis: [String] {
        emojis.shuffled().prefix(numberOfPairs).map { $0 }
    }
}
