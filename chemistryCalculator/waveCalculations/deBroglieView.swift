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

struct deBroglieView: View {
    private enum Field: Int, CaseIterable {
        case massString, velocityString
    }
    @State private var mass: Double = 0
    @State private var massString: String = ""
    @State private var velocity: Double = 0
    @State private var velocityString: String = ""
    @State private var wavelength: Double = 0
    @FocusState private var focusedField: Field?

    var body: some View {
        ZStack {
            Color.clear
                .contentShape(Rectangle())
                .onTapGesture {
                    focusedField = nil
                }
            VStack(alignment: .center) {
                Text("Input the mass in kilograms")
                    .padding()
                TextField("Mass in kilograms", text: $massString, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 275, height: 50)
                    .onChange(of: massString) {
                        mass = Double(massString) ?? 0
                    }
                    .onChange(of: mass) {
                        wavelength = (plancksConstant)/(mass * velocity)
                    }
                    .focused($focusedField, equals: .massString)
                    .keyboardType(.decimalPad)
                    .padding()
                Text("Input the velocity in meters per second")
                    .padding()
                TextField("Velocity in meters per second", text: $velocityString, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 275, height: 50)
                    .onChange(of: velocityString) {
                        velocity = Double(velocityString) ?? 0
                    }
                    .onChange(of: velocity) {
                        wavelength = (plancksConstant)/(mass * velocity)
                    }
                    .focused($focusedField, equals: .velocityString)
                    .keyboardType(.decimalPad)
                    .padding()
                if mass != 0 && velocity != 0 {
                    Text("λ = \(String(format: "%E", wavelength)) m.")
                }
                else {
                    Text("Please enter a mass and velocity.")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    deBroglieView()
}
