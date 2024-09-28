//
//  aboutView.swift
//  chemistryCalculator
//
//  Created by Tyler Davis on 9/27/24.
//

import SwiftUI

func getAppVersion() -> String {
        if let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            return appVersion
        }
        return "Unknown"
    }

func getBuildNumber() -> String {
        if let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String {
            return buildNumber
        }
        return "Unknown"
    }

struct aboutView: View {
    var body: some View {
        VStack{
            Text("App Version: v\(getAppVersion())")
            Text("Build Number: \(getBuildNumber())")
                .padding()
            Text("[Report an Issue](https://github.com/tdavis6/iosChemistryCalculator/issues/new?labels=bug&projects=&template=bug_report.md&title=%5BBUG%5D)")
                .padding()
            Text("[Request a Feature](https://github.com/tdavis6/iosChemistryCalculator/issues/new?labels=enhancement&projects=&template=feature_request.md&title=%5BFEATURE%5D)")
                .padding()
            Text("[GitHub Repository](https://github.com/tdavis6/iosChemistryCalculator)")
                .padding()
            Text("[Contact Me](mailto:coding@tydavis.dev)")
                .padding()
            Text("This application is licensed under the MIT License, found [here](https://github.com/tdavis6/Restaurant-Decider/blob/main/LICENSE).")
                .padding()
            Text("Element Data can be found [here](https://github.com/Bowserinator/Periodic-Table-JSON).")
        }
    }
}

#Preview {
    aboutView()
}
