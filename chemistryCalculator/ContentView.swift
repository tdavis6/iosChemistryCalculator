//
//  ContentView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 8/29/24.
//

import SwiftUI

let elementsData = Bundle.main.decode(Elements.self, from: "PeriodicTableJSON.json")
let elementsList: [element] = elementsData.elements
let speedOfLight = 299_792_458.0  //Speed of light in m s^-1
let rydbergConstantWavelength = 10973731.6  //Rydberg's constant in m
let rydbergConstantEnergy = 2.1798723611030 * _math.pow(10,-18) //Rydberg's constant in J
let plancksConstant = 6.62607015 * _math.pow(10,-34)
    //Planks's constant in Js https://www.nist.gov/physics/what-planck-constant

struct Elements: Hashable, Codable {
    let elements: [element]
}

struct element: Hashable, Codable, Identifiable {
    var id: Int {
        self.number
    }
    let name: String
    let appearance: String?
    let atomic_mass: Float
    let boil: Float?
    let category: String
    let density: Float?
    let discovered_by: String?
    let melt: Float?
    let molar_heat: Float?
    let named_by: String?
    let number: Int
    let period: Int
    let group: Int
    let phase: String?
    let source: String
    let bohr_model_image: String?
    let bohr_model_3d: String?
    let spectral_img: String?
    let summary: String
    let symbol: String
    let xpos: Int?
    let ypos: Int?
    let wxpos: Int?
    let wypos: Int?
    let shells: [Int]?
    let electron_configuration: String
    let electron_configuration_semantic: String
    let electron_affinity: Float?
    let electronegativity_pauling: Float?
    let ionization_energies: [Float]?
    //let cpk-hex: String
    let image: imageStruct
    let block: String?
}

struct imageStruct: Hashable, Codable {
    let title: String?
    let url: String?
    let attribution: String?
}

extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}

struct ContentView: View {
    
    var body: some View {
        NavigationView() {
            VStack {
                Spacer()
                NavigationLink(destination: listOfElementsView()) {Text("List of Elements")}
                .buttonStyle(.bordered)
                .padding()
                NavigationLink(destination: molarMassView()) {
                    Text("Molar Mass Calculator")
                }
                .buttonStyle(.bordered)
                .padding()
                NavigationLink(destination: stoichiometryView()) {Text("Stoichiometry Calculator")}
                .buttonStyle(.bordered)
                .padding()
                NavigationLink(destination: waveCalculationsView()) {Text("Wave Calculations")}
                .buttonStyle(.bordered)
                .padding()
                Spacer()
                /*NavigationLink(destination: settingsView()) {Text("Settings")}
                    .padding(0)
                    .font(.footnote)
                    .foregroundColor(.gray)*/
                NavigationLink(destination: aboutView()) {Text("About")}
                    .padding(0)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ContentView()
}
