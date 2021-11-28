//
//  ContentView.swift
//  TemperatureConverter
//
//  Created by Di Wu on 2021-11-27.
//

import SwiftUI

struct ContentView: View {
    let tempUnits: [UnitTemperature] = [ .celsius, .kelvin, .fahrenheit]
    @State private var inputValue = 0.0
    @State private var firstSelection : UnitTemperature = .celsius
    @State private var secondSelection : UnitTemperature = .celsius
    @FocusState private var valueFocused: Bool
    private var result: String {
        let inputTemp = Measurement(value: inputValue, unit: firstSelection)
        let result = inputTemp.converted(to: secondSelection)
        let formatter = MeasurementFormatter()
        formatter.unitOptions = .providedUnit
        return formatter.string(from: result)
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("unit", value: $inputValue, format: .number)
                } header: {
                    Text("Input number")
                }
                .keyboardType(.decimalPad)
                .focused($valueFocused)
                
                Section {
                    Picker("Select Unit", selection: $firstSelection){
                        ForEach(tempUnits, id:\.self) {
                            Text($0.symbol)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Input Unit")
                }
                
                Section {
                    Picker("Select Unit", selection: $secondSelection){
                        ForEach(tempUnits, id:\.self) {
                            Text($0.symbol)
                        }
                    }.pickerStyle(.segmented)
                } header: {
                    Text("Output Unit")
                }
                
                Section {
                    Text(result)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("TempConverter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        valueFocused = false
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
