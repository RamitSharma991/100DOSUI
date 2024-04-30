//
//  DetailView.swift
//  Bookworm
//
//  Created by Ramit sharma on 30/04/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    let book: Book
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                Image(book.genre)
                    .scaledToFit()
                
                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundColor(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test", author: "Test", genre: "Fantasy", review: "Quality read. Truly engaging.", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(container)
    }
    catch {
        return Text("Failed to create previews: \(error.localizedDescription)")
        
    }
}
