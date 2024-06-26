//
//  WakeUp.swift
//  BetterRest
//
//  Created by mac on 23/04/2024.
//
import CoreML
import SwiftUI

struct WakeUp: View {
    static var defaultWakeUpTime: Date {
        var component = DateComponents()
        component.hour = 7
        component.minute = 0
        
        return Calendar.current.date(from: component) ?? .now
    }
    
    @State private var sleepAmount = 8.0
    @State private var wakeUp = defaultWakeUpTime
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    func calculateBedTime () {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents(
                [.hour, .minute],
                from: wakeUp
            )
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(
                wake: Double(hour + minute),
                estimatedSleep: sleepAmount,
                coffee: Double(coffeeAmount)
            )
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(
                date: .omitted,
                time: .shortened
            )
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry there was an error calculating your bedtime"
        }
        
        showingAlert = true
    }
    
    var body: some View {
        NavigationStack{
            Form{
                Section {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker(
                        "Select Date",
                        selection: $wakeUp,
                        displayedComponents: .hourAndMinute
                    )
                    .labelsHidden()
                }
                
                
                VStack(alignment: .leading, spacing: 0) {
                    Text("Desired Amount of Sleep")
                        .font(.headline)
                    
                    Stepper(
                        "\(sleepAmount.formatted()) hours",
                        value: $sleepAmount,
                        in: 4...12,
                        step: 0.25
                    )
                }
                
                Section {
                    Picker(
                        "Daily coffee intake",
                        selection: $coffeeAmount
                    ) {
                        ForEach(1..<21) { number in
                            Text("^[\(number) cup](inflect: true)")
                        }
                    }
                }
                
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showingAlert){
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
}

#Preview {
    WakeUp()
}
