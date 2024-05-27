//
//  ContentView.swift
//  WordScramble
//
//  Created by Ramit sharma on 15/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    @State private var score = 0
    

    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                        .accessibilityElement()
                        .accessibilityLabel(word)
                        .accessibilityHint("\(word.count) letters")
                    }
                }
                
            }
            .navigationTitle(rootWord)
            .toolbar(content: {
                Button("New Word") {
                    startGame()
                }
                .foregroundColor(.red)
                .backgroundStyle(.thinMaterial)
            })
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK") {}
            } message: {
                Text(errorMessage)
            }
        }
        Spacer(minLength: 0)
        VStack {
            Text("Score: \(score)")
                .font(.title.bold())
                .foregroundColor(.cyan)
                .backgroundStyle(.thinMaterial)
            
        }
        Spacer(minLength: 0)
        
    }
    
    
    func disallowedAnswers(word: String) -> Bool {
        if newWord.count <= 3 {
            return false
        } else {
            return true
        }
    }
    
    func isNotStartWord(word: String) -> Bool {
        if rootWord == newWord {
            return false
        } else {
            return true
        }
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let position = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: position)
            } else {
                return false
            }
        }
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
    
    func startGame() {
        if let startWordsUrl = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsUrl) {
                let allWords = startWords.components(separatedBy: "\n")
                
                rootWord = allWords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count > 0 else { return }
        
        guard disallowedAnswers(word: answer) else {
            wordError(title: "Too short!", message: "minimum 4 letters required")
            score -= 1
            return
        }
        
        guard isNotStartWord(word: answer) else {
            wordError(title: "Oops! Thats the originial word.", message: "try being less obvious")
            score -= 1
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            score -= 1
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            score -= 1
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't make up words, Okay?")
            score -= 1
            return
        }
        score += answer.count * 2
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        newWord = ""
    }
    
}

#Preview {
    ContentView()
}
