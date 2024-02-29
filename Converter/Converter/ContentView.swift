//
//  ContentView.swift
//  Converter
//
//  Created by Ramit sharma on 26/02/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputTemp = 0.0
    @State private var inputType = "Celsius"
    @State private var OutputType = "Fahrenheit"
    
    let tempTypes = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var baseOutput: Double {
        let ip = inputTemp
        let ipType = inputType
        let convertFromC = ip
        let convertFromF = (ip - 32) * 5/9
        let convertFromK = ip - 273.15
        
        if ipType == "Celsius" {
            return convertFromC
        } else if ipType == "Fahrenheit" {
            return convertFromF
        } else {
            return convertFromK
        }
    }
    
    var finalOutput: Double {
        let op = baseOutput
        let opType = OutputType
        let opToC = op
        let opToF = (op * (9/5)) + 32
        let opToK = op + 273.15
        
        if opType == "Celsius" {
            return opToC
        } else if opType == "Fahrenheit" {
            return opToF
        } else {
            return opToK
        }
        
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                
                Section("Input ") {
                    TextField("Enter temp value", value: $inputTemp, format: .number)
                    
                    Picker("Input Units", selection: $inputType) {
                        ForEach(tempTypes, id: \.self) {
                            Text("\($0)°")
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Output") {
                    Picker("Output Units", selection: $OutputType) {
                        ForEach(tempTypes, id: \.self) {
                            Text("\($0)°")
                        }
                    }.pickerStyle(.segmented)
                    
                    Text(finalOutput, format: .number)
                    
                }
            }
            .navigationTitle("Converter")
        }
    }
}

#Preview {
    ContentView()
}
