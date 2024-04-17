//
//  ContentView.swift
//  iExpense
//
//  Created by Ramit sharma on 20/03/24.
//

import SwiftUI


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    
    @State private var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Personal Expenses")) {
                    ForEach(expenses.items.filter { $0.type == "Personal"}) { item in
                        expenseSection(item: item)
                    }
                    .onDelete(perform: removeItems)
                }
                Section(header: Text("Business Expenses")) {
                    ForEach(expenses.items.filter { $0.type == "Business"}) { item in
                        expenseSection(item: item)
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    showingAddExpense = true
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
                    .onDisappear {
                        showingAddExpense = false
                    }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct expenseSection: View {
    let item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline).bold()
                Text(item.type)
                    .fontWeight(.thin)
                
            }
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundColor(colorCode(for: item.amount))
                .font(.title2)
        }
        
    }
    
}

func colorCode(for amount: Double) -> Color {
    if amount < 10 {
        return .green
    } else if  amount < 100 {
        return .yellow
    } else {
        return .red
    }
}



#Preview {
    ContentView()
}
