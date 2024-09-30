//
//  waveLengthView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 9/28/24.
//

import SwiftUI

struct waveLengthView: View {
    private enum Field: Int, CaseIterable {
        case frequencyString
    }
    @State private var frequency: Double = 0
    @State private var frequencyString: String = ""
    @FocusState private var focusedField: Field?

    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    focusedField = nil
                }
            VStack(alignment: .center) {
                Text("Input the frequency in Hz")
                    .padding()
                TextField("Frequency in Hz", text: $frequencyString, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 275, height: 50)
                    .onChange(of: frequencyString) {
                        frequency = Double(frequencyString) ?? 0
                    }
                    .focused($focusedField, equals: .frequencyString)
                    .keyboardType(.decimalPad)
                    .padding()
                if frequency != 0 {
                    Text("λ = \(String(format: "%E", speedOfLight/frequency)) m.")
                }
                else {
                    Text("Please enter a frequency.")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    waveLengthView()
}
