//
//  AddBookView.swift
//  Bookworm
//
//  Created by Ramit sharma on 26/04/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = "Kids"
    @State private var review = ""
    
    let genres = ["Fantasy", "Mystery", "Poetry", "Kids", "Romance", "Horror", "Thriller"]
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    HStack {
                        Text("Your rating : ")
                        RatingView(rating: $rating)
                    }
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(title.isEmpty || author.isEmpty || review.isEmpty)
                }
            }
            .navigationTitle("Add Book")
        }
    }
}
