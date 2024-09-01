//
//  StepIdentifiable.swift
//  StepKit
//
//  Created by Luca Casula on 01/09/24.
//

import Foundation

internal protocol StepIdentifiable {
    var id: String { get }
    func generateStepIdentifier() -> String
}

extension StepIdentifiable {
    var id: String {
        return generateStepIdentifier()
    }
}

internal class StepIdentifierProvider {

    internal var stepIdentifier: String
    
    internal init(elements: String?...) {
        let arrayElements = elements.compactMap { $0 }
        let joinedString = arrayElements.joined()
        let hash = joinedString.data(using: .utf8)?.base64EncodedString() ?? joinedString

        self.stepIdentifier = hash
    }
}
