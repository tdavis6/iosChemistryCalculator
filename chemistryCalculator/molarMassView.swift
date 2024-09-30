//
//  molarMassView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 8/29/24.
//

import SwiftUI

struct molarMassView: View {
    private enum Field: Int, CaseIterable {
        case formulaInput
    }
    @State private var molecularFormula: String = ""
    @State private var molarMass: Double?
    @FocusState private var focusedField: Field?
    
    let elements: [element] = elementsList
    
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    focusedField = nil
                }
            VStack(alignment: .center) {
                Text("Insert the molecular formula below:")
                TextField("Molecular Formula", text: $molecularFormula, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 275, height: 50)
                    .onChange(of: molecularFormula) {
                        molarMass = calculateMolarMass(formula: molecularFormula) ?? 0
                    }
                    .focused($focusedField, equals: .formulaInput)
                    .padding()
                if molarMass == nil {
                    Text("Enter a molecular formula to calculate the molar mass.")
                }
                else if molarMass == 0 {
                    Text("Enter a molecular formula to calculate the molar mass.")
                }
                else {
                    Text("The molar mass is \(molarMass ?? 0, specifier: "%.\(3)f") g mol\(Text("-1").baselineOffset(8).font(.caption)).")
                }
            }
        }
    }
}

#Preview {
    molarMassView()
}
