//
//  stoichiometryCalculator.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 9/28/24.
//

struct stoichiometryData {
    var finalValue: Double
    var finalUnits: String
}

func convertToMoles(initialValue: Double, initialMolecule: String, startingSelection: String) -> Double {
    var moles:Double = 0
    let avogadrosNumber = 6.02214076e23 // https://www.britannica.com/science/Avogadros-number
    
    if startingSelection == "Moles" {
        return initialValue
    }
    else if startingSelection == "Grams" {
        moles = initialValue / (calculateMolarMass(formula: initialMolecule) ?? 0)
        return moles
    }
    else if startingSelection == "Particles" {
        moles = initialValue / avogadrosNumber
        return moles
    }
    else if startingSelection == "Liters" {
        moles = initialValue / 22.4
        return moles
    }
    else {
        return 0
    }
}

func convertFromMoles(moles: Double, finalMolecule: String, endingSelection: String) -> Double {
    let avogadrosNumber = 6.02214076e23 // https://www.britannica.com/science/Avogadros-number
    
    if endingSelection == "Moles" {
        return moles
    }
    else if endingSelection == "Grams" {
        return moles * (calculateMolarMass(formula: finalMolecule) ?? 0)
    }
    else if endingSelection == "Particles" {
        return moles * avogadrosNumber
    }
    else if endingSelection == "Liters" {
        return moles * 22.4
    }
    else {
        return 0
    }
}

func findFinalUnits(endingSelection: String) -> String {
    if endingSelection == "Moles" {
        return "mol"
    }
    else if endingSelection == "Grams" {
        return "g"
    }
    else if endingSelection == "Particles" {
        return " particles"
    }
    else if endingSelection == "Liters" {
        return "L"
    }
    else {
        return ""
    }
}

func stoichiometryCalculator(startingSelection: String, endingSelection: String, initialValue: Double, initialMolecule: String, finalMolecule: String) -> stoichiometryData? {
    var finalUnits:String = ""
    var finalValue:Double = 0
    var moles:Double = 0
    var stoichiometryData:stoichiometryData = stoichiometryData(finalValue: 0, finalUnits: "")
    
    moles = convertToMoles(initialValue: initialValue, initialMolecule: initialMolecule, startingSelection: startingSelection)
    if moles.isNaN {
        moles = 0
    }
    finalValue = convertFromMoles(moles: moles, finalMolecule: finalMolecule, endingSelection: endingSelection)
    finalUnits = findFinalUnits(endingSelection: endingSelection)
    
    stoichiometryData.finalValue = finalValue
    stoichiometryData.finalUnits = finalUnits
    return(stoichiometryData)
}
