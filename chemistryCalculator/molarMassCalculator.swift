//
//  molarMassCalculator.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 9/28/24.
//

import Foundation

func calculateMolarMass(formula: String) -> Double? {
    let elements: [element] = elementsList
    // Regular expression to match elements and their subscripts
    let regex = try! NSRegularExpression(pattern: "[A-Z][a-z]?|\\d+")

    let matches = regex.matches(in: formula, range: NSRange(location: 0, length: formula.utf16.count))

    var result = [String]()
    
    // Extract matches and create an array of element symbols and subscripts
    for match in matches {
        if let range = Range(match.range, in: formula) {
            result.append(String(formula[range]))
        }
    }

    var totalMolarMass = 0.0
    var i = 0
    
    // Iterate through the array of symbols and subscripts
    while i < result.count {
        let element = result[i]
        
        // Check if the element exists in the molar mass dictionary
        if let mass = elements.first(where: { $0.symbol == element })?.atomic_mass {
            var quantity = 1 // Default quantity (if no subscript)
            
            // If the next element is a number, parse it as a subscript
            if i + 1 < result.count, let subscriptValue = Int(result[i + 1]) {
                quantity = subscriptValue
                i += 1 // Skip the next number, as it was parsed as a subscript
            }
            
            // Add the element's molar mass times the quantity to the total
            totalMolarMass += Double(mass) * Double(quantity)
        } else {
            print("Element \(element) not found in the molar mass table.")
            return nil
        }
        
        i += 1
    }
    return totalMolarMass
}
