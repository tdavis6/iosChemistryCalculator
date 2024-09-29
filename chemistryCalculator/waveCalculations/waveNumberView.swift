//
//  waveNumberView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 9/28/24.
//

import SwiftUI

struct waveNumberView: View {
    private enum Field: Int, CaseIterable {
        case wavelengthString
    }
    @State private var wavelength: Double = 0
    @State private var wavelengthString: String = ""
    @FocusState private var focusedField: Field?

    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    focusedField = nil
                }
            VStack(alignment: .center) {
                Text("Input the wavelength in centimeters")
                    .padding()
                TextField("Wavelength in centimeters", text: $wavelengthString, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 275, height: 50)
                    .onChange(of: wavelengthString) {
                        wavelength = Double(wavelengthString) ?? 0
                    }
                    .focused($focusedField, equals: .wavelengthString)
                    .keyboardType(.decimalPad)
                    .padding()
                Text("The wavenumber is \(String(format: "%E", 1/wavelength)).")
                Spacer()
            }
        }
    }
}
#Preview {
    waveNumberView()
}
