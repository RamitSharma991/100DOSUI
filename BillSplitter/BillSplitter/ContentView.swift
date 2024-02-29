//
//  ContentView.swift
//  BillSplitter
//
//  Created by Ramit sharma on 26/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var people = 2
    @State private var tipPercentage = 20
    @FocusState private var isAmountFocused: Bool
    
    let tipPercentages = [10, 15, 20, 25, 0]
    
    var totalPerPerson: Double {
        let peopleCount = Double(people + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let splitBill = grandTotal / peopleCount
        
        return splitBill
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isAmountFocused)
                    
                    Picker("Number of people", selection: $people) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                Section("Add a Tip %") {
                    Picker("Tip %age", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0 , format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                }
                

            }
            .navigationTitle("Bill Splitter")
            .toolbar {
                if isAmountFocused {
                    Button("Done") {
                        isAmountFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
