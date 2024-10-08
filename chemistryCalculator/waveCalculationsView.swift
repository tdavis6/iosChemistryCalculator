//
//  waveCalculationsView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 9/28/24.
//

import SwiftUI

struct waveCalculationsView: View {
    let selections = ["Wave Length", "Frequency", "Wave Number", "Balmer-Rydberg", "De Broglie"]
    @State private var selected: String = "Wave Length"
    var body: some View {
        NavigationView() {
            VStack {
                Picker("Select a calculation", selection: $selected) {
                    ForEach(selections, id: \.self) { selection in
                        Text(selection)
                    }
                }
                .pickerStyle(.automatic)
                    .padding()
                Spacer()
                if selected == "Wave Length" {
                    waveLengthView()
                }
                else if selected == "Frequency" {
                    frequencyView()
                }
                else if selected == "Wave Number" {
                    waveNumberView()
                }
                else if selected == "Balmer-Rydberg" {
                    balmerRydbergView()
                }
                else if selected == "De Broglie" {
                    deBroglieView()
                }
            }
        }
    }
}

#Preview {
    waveCalculationsView()
}
