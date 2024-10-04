//
//  VSEPRView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 10/4/24.
//

import SwiftUI

struct molecularGeometryView: View {
    let electronGroups = [2,3,4,5,6]
    @State var selected: Int = 0
    var body: some View {
        NavigationView() {
            VStack {
                Text("Test")
                }
            }
        }
    }

#Preview {
    molecularGeometryView()
}
