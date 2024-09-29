//
//  listOfElementsView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 9/27/24.
//

import SwiftUI

struct elementRowView: View {
    let element: element
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("\(element.name) (\(element.symbol))")
                .font(.headline)
            Text("Atomic Number: \(element.number)")
            Text("Atomic Mass: \(element.atomic_mass)")
            Text("Category: \(element.category)")
        }
    }
}

struct elementPopoverView: View {
    let element: element
    
    var body: some View {
        VStack(alignment: .center) {
            Text("\(element.name) (\(element.symbol))")
                .font(.headline)
                .padding()
            Text("Atomic Number: \(element.number)")
                .padding()
            Text("Atomic Mass: \(element.atomic_mass)")
                .padding()
            Text("Category: \(element.category)")
                .padding()
            Text("Semantic Electron Configuration: \(element.electron_configuration_semantic)")
                .padding()
            Text("Full Electron Configuration: \(element.electron_configuration)")
                .padding()
            if element.electron_affinity != nil {
                Text("Electron Affinity: \(element.electron_affinity!)")
                    .padding()
            }
            else {
                Text("Electron Affinity: unknown")
                    .padding()
            }
            if element.ionization_energies != nil {
                if element.ionization_energies!.count > 1 {
                    Text("Ionization Energies: \(element.ionization_energies!.map{String($0)}.joined(separator: ", ")) kJ mol\(Text("-1").baselineOffset(8).font(.caption)).")
                        .padding()
                }
                else {
                    Text("Ionization Energy: \(element.ionization_energies!.map{String($0)}.joined(separator: ", ")) kJ mol \(Text("-1").baselineOffset(8).font(.caption)).")
                        .padding()
                }
            }
            else {
                Text("Ionization Energy: unknown")
                    .padding()
            }
            if element.phase != nil {
                Text("Phase at STP: \(element.phase!)")
                    .padding()
            }
            else {
                Text("Phase at STP: unknown")
                    .padding()
            }
            Text(element.summary)
                .padding()
        }
    }
}

struct listOfElementsView: View {
    let elements: [element] = elementsList
    @State private var searchText: String = ""
    @State private var selection: element?
    @State private var isDetailsPopoverPresented: Bool = false
    
    var body: some View {
        List(selection: $selection) {
            if searchText.isEmpty {
                ForEach(elements, id: \.self) { element in
                    elementRowView(element: element)
                }
            }
            else {
                ForEach(elements, id: \.self) { element in
                    if element.name.lowercased().contains(searchText.lowercased()) {
                        elementRowView(element: element)
                    }
                    else if String(element.number).lowercased().contains(searchText.lowercased()) {
                        elementRowView(element: element)
                    }
                    else if element.electron_configuration_semantic.lowercased().contains(searchText.lowercased()) {
                        elementRowView(element: element)
                    }
                    else if element.electron_configuration.lowercased().hasSuffix(searchText.lowercased()) {
                        elementRowView(element: element)
                    }
                    else if element.category.lowercased().contains(searchText.lowercased()) {
                        elementRowView(element: element)
                    }
                    else if element.phase!.lowercased().contains(searchText.lowercased()) {
                        elementRowView(element: element)
                    }
                }
            }
        }
        .onChange(of: selection) {
            if selection != nil {
                isDetailsPopoverPresented = true
            }
        }
        .onChange(of: isDetailsPopoverPresented) {
            if isDetailsPopoverPresented == false {
                selection = nil
            }
        }
        .searchable(text: $searchText)
        .popover(isPresented: $isDetailsPopoverPresented) {
            if selection != nil {
                elementPopoverView(element: selection!)
            }
            else {
                Text("Select an element to see details")
            }
        }
        .presentationCompactAdaptation(.sheet)
        .navigationBarTitle("Elements")
    }
}

#Preview {
    listOfElementsView()
}
