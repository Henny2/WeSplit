//
//  ContentView.swift
//  WeSplit
//
//  Created by Henrieke Baunack on 10/8/23.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    let tipPercentages = [0, 10, 15, 20, 25]
    
    
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    
    var tipValue: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        return tipValue
    }
    var grandTotal: Double{
        return tipValue + checkAmount
    }

    
    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople){
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                       
                    }
                    // .pickerStyle(.navigationLink) if you want to change the style of the picker
                }
//                Section("How much tip do you want to add?"){
//                    Picker("Tip Percentage Picker", selection: $tipPercentage){
//                        ForEach(tipPercentages, id: \.self) {
//                            Text($0, format: .percent)
//                        }
//                    }
//                    .pickerStyle(.segmented)
//                }
                Section("How much tip do you want to add?"){
                    Picker("Tip Percentage", selection: $tipPercentage){
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                    
                    
                }
                Section("Totals"){
                    VStack{
                        HStack {
                            Text("Check Total:")
                            Spacer()
                            Text(checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }
                        HStack{
                            Text("Tip:")
                            Spacer()
                            Text(tipValue, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        }.foregroundStyle(tipPercentage == 0 ? Color.red : Color.black)
                    }
                    HStack{
                        Text("Grand Total:")
                        Spacer()
                        Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
                Section("Amount per Person"){
                    HStack{
                        Text("Total per person:")
                        Spacer()
                        Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
                if amountIsFocused {
                    Button("Done"){
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
