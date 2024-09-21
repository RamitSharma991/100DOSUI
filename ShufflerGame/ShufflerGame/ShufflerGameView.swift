//
//  ShufflerGameView.swift
//  ShufflerGame
//
//  Created by Ramit Sharma on 16/09/24.
//

import SwiftUI

struct ShufflerGameView: View {
    
    @ObservedObject var viewModel: ShufflerViewModel
    @State private var isStarted = false
    
    var body: some View {
        ZStack {
            if isStarted {
                VStack {
                    themeBanners
                    ScrollView {
                        cards
                            .animation(.easeInOut, value: viewModel.cards)
                    }
                    Button("Shuffle") {
                        viewModel.shuffle()
                    }
                    .font(.title2.monospaced().bold())
                }
                .padding()
                .foregroundColor(viewModel.themeColor)
            }
            else {
                VStack {
                    ZStack {
                        Image("artIcon").resizable().frame(width: 300, height: 300).opacity(0.5)
                        Button("Start") {
                            withAnimation {
                                randomStart()
                                isStarted = true
                            }
                        }
                        .font(.largeTitle.monospaced().bold()).shadow(radius: 10)
                    }
                    .animation(.easeInOut, value: isStarted)
                }
            }
        }
    }
    
    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 85), spacing: 0)], spacing: 0) {
            ForEach(viewModel.cards) { card in
                CardView(card)
                    .aspectRatio(2/3, contentMode: .fit)
                    .padding(4)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
        }
        .foregroundColor(viewModel.themeColor.opacity(0.3))
    }
    
    var themeBanners: some View {
        VStack {
            HStack(alignment: .center) {
                Text("Emoji Game").font(.largeTitle.monospaced().bold()).foregroundColor(viewModel.themeColor)
                Text("Score: \(viewModel.score)").font(.title2).bold().padding()
            }
            .padding()
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    Button("Sports") {
                        viewModel.changeTheme(to: ShufflerViewModel.sportsTheme)
                    }
                    Button("Animals") {
                        viewModel.changeTheme(to: ShufflerViewModel.animalsTheme)
                    }
                    Button("Halloween") {
                        viewModel.changeTheme(to: ShufflerViewModel.halloweenTheme)
                    }
                    
                    Button("Fruits") {
                        viewModel.changeTheme(to: ShufflerViewModel.fruitsTheme)
                    }
                    Button("Vehicles") {
                        viewModel.changeTheme(to: ShufflerViewModel.vehiclesTheme)
                    }
                    Button("Space") {
                        viewModel.changeTheme(to: ShufflerViewModel.spaceTheme)
                    }
                    
                }
                .font(.subheadline.monospaced().bold())
            }
            .frame(height: 20)
            .padding()
        }
    }
    
    private func randomStart() {
        let themes = [
            ShufflerViewModel.sportsTheme,
            ShufflerViewModel.animalsTheme,
            ShufflerViewModel.halloweenTheme,
            ShufflerViewModel.fruitsTheme,
            ShufflerViewModel.vehiclesTheme,
            ShufflerViewModel.spaceTheme
        ]
        
        if let randomTheme = themes.randomElement() {
            viewModel.changeTheme(to: randomTheme)
        }
    }
}

struct CardView: View {
    let card: ShufflerModel<String>.Card
    
    init(_ card: ShufflerModel<String>.Card) {
        self.card = card
    }
    
    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 15)
            
            Group {
                base.fill(.clear)
                base.strokeBorder(lineWidth: 2)
                Text(card.content)
                    .font(.system(size: 200))
                    .minimumScaleFactor(0.01)
                    .aspectRatio(1, contentMode: .fit)
            }
            .opacity(card.isFaceUp ? 1 : 0)
            base.fill().opacity(card.isFaceUp ? 0 : 1)
        }
        .opacity(card.isFaceUp || !card.isMatched ? 1 : 0)
    }
}

#Preview {
    ShufflerGameView(viewModel: ShufflerViewModel())
}
