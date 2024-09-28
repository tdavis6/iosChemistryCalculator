//
//  stoichiometryView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 9/27/24.
//

import SwiftUI

func handleDataChange(startingSelection: String, endingSelection: String, initialValue: Double, initialMolecule: String, finalMolecule: String) -> stoichiometryData {
    return stoichiometryCalculator(startingSelection: startingSelection, endingSelection: endingSelection, initialValue: initialValue, initialMolecule: initialMolecule, finalMolecule: finalMolecule) ?? stoichiometryData(finalValue: 0, finalUnits: "")
}

struct stoichiometryView: View {
    private enum Field: Int, CaseIterable {
        case initialMolecule, initialValueString, finalMolecule
    }

    @FocusState private var focusedField: Field?
    private let choices = ["Grams", "Moles", "Particles", "Liters"]
    private let units = ["g", "mol", "particles", "L"]
    @State private var startingSelection: String = "Grams"
    @State private var endingSelection: String = "Grams"
    @State private var initialValueString: String = ""
    @State private var initialValue: Double = 0
    @State private var initialMolecule: String = ""
    @State private var finalMolecule: String = ""
    @State private var finalValue: String = ""
    @State private var finalUnits: String = ""
    @State private var stoichiometryCalculatedData: stoichiometryData = stoichiometryData(finalValue: 0, finalUnits: "")
    @State private var roundedFinalValue: String = ""
    let elements: [element] = elementsList
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    focusedField = nil
                }
            GeometryReader { geometry in
                VStack {
                    Text("Enter the starting molecule below.")
                    TextField("Initial molecule", text: $initialMolecule, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 275, height: 50)
                        .focused($focusedField, equals: .initialMolecule)
                    Text("Enter the starting value below, without units.")
                    TextField("Initial value", text: $initialValueString, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 275, height: 50)
                        .keyboardType(.decimalPad)
                        .onChange(of: initialValueString) {
                            initialValue = Double(initialValueString) ?? 0
                        }
                        .focused($focusedField, equals: .initialValueString)
                    Text("What are you starting with?")
                    Picker("Select starting selection", selection: $startingSelection) {
                        ForEach(choices, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    Text("Enter the final molecule below.")
                    TextField("Final molecule", text: $finalMolecule, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                        .frame(width: 275, height: 50)
                        .focused($focusedField, equals: .finalMolecule)
                    Text("What are you converting to?")
                    Picker("Select ending selection", selection: $endingSelection) {
                        ForEach(choices, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .onChange(of: startingSelection) {
                        stoichiometryCalculatedData = handleDataChange(startingSelection: startingSelection, endingSelection: endingSelection, initialValue: initialValue, initialMolecule: initialMolecule, finalMolecule: finalMolecule)
                    }
                    .onChange(of: endingSelection) {
                        stoichiometryCalculatedData = handleDataChange(startingSelection: startingSelection, endingSelection: endingSelection, initialValue: initialValue, initialMolecule: initialMolecule, finalMolecule: finalMolecule)
                    }
                    .onChange(of: initialValue) {
                        stoichiometryCalculatedData = handleDataChange(startingSelection: startingSelection, endingSelection: endingSelection, initialValue: initialValue, initialMolecule: initialMolecule, finalMolecule: finalMolecule)
                    }
                    .onChange(of: initialMolecule) {
                        stoichiometryCalculatedData = handleDataChange(startingSelection: startingSelection, endingSelection: endingSelection, initialValue: initialValue, initialMolecule: initialMolecule, finalMolecule: finalMolecule)
                    }
                    .onChange(of: finalMolecule) {
                        stoichiometryCalculatedData = handleDataChange(startingSelection: startingSelection, endingSelection: endingSelection, initialValue: initialValue, initialMolecule: initialMolecule, finalMolecule: finalMolecule)
                    }
                    
                    if stoichiometryCalculatedData.finalValue != 0 {
                        if stoichiometryCalculatedData.finalValue >= 10000 {
                            Text("The final value is \(String(format: "%e", stoichiometryCalculatedData.finalValue))\(stoichiometryCalculatedData.finalUnits) of \(finalMolecule).")
                                .padding()
                        }
                        else {
                            Text("The final value is \(String(format: "%.3f", stoichiometryCalculatedData.finalValue))\(stoichiometryCalculatedData.finalUnits) of \(finalMolecule).")
                                .padding()
                        }
                    }
                    else {
                        Text("Please enter a value to calculate.")
                            .padding()
                    }
                    Button("Reset values") {
                        startingSelection = "Grams"
                        endingSelection = "Grams"
                        initialValueString = ""
                        initialValue = 0
                        initialMolecule = ""
                        finalMolecule = ""
                        finalValue = ""
                        finalUnits = ""
                    }
                    .padding()
                    Text("Assume all volumes are at STP.").font(.footnote)
                        .padding()
                }
                .toolbar {
                    if focusedField != nil {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Done") {
                                focusedField = nil
                            }
                        }
                    }
                }
            }.ignoresSafeArea(.keyboard, edges: .all)
        }
    }
}

#Preview {
    stoichiometryView()
}
