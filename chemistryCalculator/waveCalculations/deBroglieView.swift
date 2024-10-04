//
//  frequencyView 2.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 10/4/24.
//


//
//  frequencyView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 9/28/24.
//

import SwiftUI

struct frequencyView: View {
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
                Text("Input the wavelength in meters")
                    .padding()
                TextField("Wavelength in meters", text: $wavelengthString, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 275, height: 50)
                    .onChange(of: wavelengthString) {
                        wavelength = Double(wavelengthString) ?? 0
                    }
                    .focused($focusedField, equals: .wavelengthString)
                    .keyboardType(.decimalPad)
                    .padding()
                if wavelength != 0 {
                    Text("𝜈 = \(String(format: "%E", speedOfLight/wavelength)) Hz.")
                }
                else {
                    Text("Please enter a wavelength.")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    frequencyView()
}
