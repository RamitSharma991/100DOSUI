//
//  ContentView.swift
//  BetterRest
//
//  Created by Ramit sharma on 11/03/24.
//

import SwiftUI
import CoreML

struct ContentView: View {
    
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
        
    }
    
    var sleepResults: String {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            
            return "Your ideal bedtime is " + sleepTime.formatted(date: .omitted, time: .shortened)
            
        }
        catch {
            return "Error ⚠️"
        }
        
    }
    
    var body: some View {
        
        NavigationStack {
            Form {
                Section(header: Text("When do you want to wake up ?")) {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                
                Section(header: Text("Desired amount of sleep")) {
                    Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                Section(header: Text("Desired Coffee intake")) {
                    Picker(selection: $coffeeAmount, label: Text("Number of cups")) {
                        ForEach(1...20, id: \.self) { cup in
                            Text("\(cup) cup\(cup == 1 ? "" : "s")")
                            
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section {
                    Text(sleepResults)
                        .font(.title.bold())
                        .foregroundColor(.red)
                        
        
                }
                
            }
            .navigationTitle("Better Rest")
        }
        
    }
    
}

#Preview {
    ContentView()
}



/*
 
 
 
 .toolbar {
 Button("Calculate", action: calculateBedtime)
 }
 
 .alert(alertTitle, isPresented: $showingAlert) {
 Button("Ok") {}
 }
 message: {
 Text(alertMessage)
 }
 
 
 func calculateBedtime() {
 
 do {
 let config = MLModelConfiguration()
 let model = try SleepCalculator(configuration: config)
 let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
 let hour = (components.hour ?? 0) * 60 * 60
 let minute = (components.minute ?? 0) * 60
 let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
 let sleepTime = wakeUp - prediction.actualSleep
 
 alertTitle = "Your ideal bedtime is"
 alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
 
 }
 catch {
 
 alertTitle = "Error ⚠️"
 alertMessage = "Sorry, there was a problem calculating your bedtime"
 
 }
 showingAlert = true
 
 }
 
 */
