//
//  balmerRydbergView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 9/28/24.
//

import SwiftUI

func balmerRydbergWavelength(initial: Double, final: Double) -> Double {
    var answer: Double = 0
    answer = Double(1/pow(final, 2) - 1/pow(initial, 2))
    answer = Double(rydbergConstantWavelength) * answer
    answer = 1/answer
    return answer
}

func balmerRydbergFrequency(initial: Double, final: Double) -> Double {
    var answer: Double = 0
    answer = Double(1/pow(final, 2) - 1/pow(initial, 2))
    answer = Double(rydbergConstantWavelength) * answer
    answer = 1/answer
    answer = speedOfLight/answer
    return answer
}

func balmerRydbergEnergy(initial: Double, final: Double) -> Double {
    var answer: Double = 0
    answer = Double(1/pow(final, 2) - 1/pow(initial, 2))
    answer = Double(rydbergConstantEnergy) * answer
    return answer
}

struct balmerRydbergView: View {
    private enum Field: Int, CaseIterable {
        case initialString, finalString
    }
    @State private var initial: Double = 0
    @State private var initialString: String = ""
    @State private var final: Double = 0
    @State private var finalString: String = ""
    @FocusState private var focusedField: Field?
    @State var balmerRydbergWavelengthAnswer:Double = 0
    @State var balmerRydbergFrequencyAnswer:Double = 0
    @State var balmerRydbergEnergyAnswer:Double = 0
    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    focusedField = nil
                }
            VStack(alignment: .center) {
                Text("Input the initial atomic number")
                TextField("Initial atomic number", text: $initialString, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 275, height: 50)
                    .onChange(of: initialString) {
                        initial = Double(initialString) ?? 0
                    }
                    .focused($focusedField, equals: .initialString)
                    .keyboardType(.decimalPad)
                    .padding()
                Text("Input the final atomic number")
                TextField("Final atomic number", text: $finalString, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 275, height: 50)
                    .onChange(of: finalString) {
                        final = Double(finalString) ?? 0
                    }
                    .focused($focusedField, equals: .finalString)
                    .keyboardType(.decimalPad)
                    .padding()
                    .onChange(of: initial) {
                        balmerRydbergWavelengthAnswer = balmerRydbergWavelength(initial: initial, final: final)
                    }
                    .onChange(of: final) {
                        balmerRydbergWavelengthAnswer = balmerRydbergWavelength(initial: initial, final: final)
                    }
                    .onChange(of: initial) {
                        balmerRydbergFrequencyAnswer = balmerRydbergFrequency(initial: initial, final: final)
                    }
                    .onChange(of: final) {
                        balmerRydbergFrequencyAnswer = balmerRydbergFrequency(initial: initial, final: final)
                    }
                    .onChange(of: initial) {
                        balmerRydbergEnergyAnswer = balmerRydbergEnergy(initial: initial, final: final)
                    }
                    .onChange(of: final) {
                        balmerRydbergEnergyAnswer = balmerRydbergEnergy(initial: initial, final: final)
                    }
                VStack {
                    Text("λ = \(String(format: "%E", balmerRydbergWavelengthAnswer)) m.")
                        .padding()
                    Text("𝜈 = \(String(format: "%E", balmerRydbergFrequencyAnswer)) Hz.")
                        .padding()
                    Text("E = \(String(format: "%E", balmerRydbergEnergyAnswer)) J.")
                        .padding()
                }
                .frame(width: 350)
                Spacer()
            }
        }
    }
}

#Preview {
    balmerRydbergView()
}
