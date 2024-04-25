//
//  ContentView.swift
//  BetterRest
//
//  Created by mac on 23/04/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var sleepAmount = 8.0
    @State private var wakeUp = Date.now
    @State private var coffeeAmount = 1
    
//    func exampleDates() {
//        var components = DateComponents()
//        components.hour = 8
//        components.minute = 0
//        let date = Calendar.current.date(from: components) ?? .now
//        
//        let components = Calendar.current.dateComponents(
//            [.hour, .minute],
//            from: .now
//        )
//        let hour = components.hour ?? 0
//        let minute = components.minute ?? 0
//    }
    
    var body: some View {
        //Date Picker
        Text(
            Date.now.formatted(
                date: .long,
                time: .shortened
            )
        )
//        DatePicker(
//            "Please pick a Date",
//            selection: $wakeUp,
//            in: Date.now...,
//            displayedComponents: .date
//        )
//        .labelsHidden()
        
        
        // Stepper Widget
//        Stepper(
//            "\(sleepAmount.formatted()) hours",
//            value: $sleepAmount,
//            in: 4...15,
//            step: 0.25
//        )
    }
}

#Preview {
    ContentView()
}
