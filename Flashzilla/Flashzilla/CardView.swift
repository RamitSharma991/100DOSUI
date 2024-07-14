//
//  CardView.swift
//  Flashzilla
//
//  Created by Ramit Sharma on 12/07/24.
//

import SwiftUI

struct CardView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.accessibilityVoiceOverEnabled) var accessibilityVoiceOverEnabled
    @State private var isShowingAnswer = false
    @State private var offset = CGSize.zero
    
    let card: Card
    var removal: ((Bool) -> Void)? = nil
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(
                    accessibilityDifferentiateWithoutColor ? .white : .white.opacity(1 - Double(abs(offset.width / 20)))
                )
                .background(
                    accessibilityDifferentiateWithoutColor ? nil : RoundedRectangle(cornerRadius: 25)
                        .fill(offset.width > 0 ? .green : .red)
                    
                )
                .shadow(radius: 10)
            
            VStack {
                if accessibilityVoiceOverEnabled {
                    Text(isShowingAnswer ? card.answer : card.prompt)
                        .font(.title)
                        .foregroundStyle(.black)
                } else {
                    Text(card.prompt)
                        .font(.title)
                        .foregroundStyle(.black)
                    
                    if isShowingAnswer {
                        Text(card.answer)
                            .font(.caption.bold())
                            .foregroundStyle(.gray)
                    }
                }
            }
            .padding(20)
            .multilineTextAlignment(.center)
        }
        .frame(width: 400, height: 200)
        .rotationEffect(.degrees(offset.width / 5.0))
        .offset(x: offset.width)
        .opacity(2 - Double(abs(offset.width / 50)))
        .accessibilityAddTraits(.isButton)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    offset = gesture.translation
                }
                .onEnded { _ in
                    if abs(offset.width) > 100 {
                        removal?(offset.width > 0)
                    } else {
                        offset = .zero
                    }
                    
                }
        )
        .onTapGesture {
            isShowingAnswer.toggle()
        }
        .animation(.default, value: offset)
    }
}

#Preview {
    CardView(card: .example)
}
