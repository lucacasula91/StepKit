import Foundation

/// An object that generate an identifier using string elements provided.
internal class StepIdentifierProvider {

    /// The generated identifier.
    internal var stepIdentifier: String
    
    /// Create a new instance of ``StepIdentifierProvider`` with the provided components.
    /// - Parameter elements: Array of elements with which create an identifier.
    internal init(elements: String?...) {
        let arrayElements = elements.compactMap { $0 }
        let joinedString = arrayElements.joined()
        let stepIdentifier = joinedString.data(using: .utf8)?.base64EncodedString() ?? joinedString

        self.stepIdentifier = stepIdentifier
    }
}

/// Protocol that define methods and values to handle a
internal protocol StepIdentifiable {

    /// The identifier value generated using elements provided.
    ///
    /// Identifiers should be generated using the ``StepIdentifiable/generateStepIdentifier()`` function provided within ``StepIdentifiable`` protocol.
    var id: String { get }

    /// Method in which define the logic to generate the identifier.
    ///
    /// ``StepKit`` provides ``StepIdentifierProvider`` class with which generate identifiers in a cleaver way.
    func generateStepIdentifier() -> String
}

extension StepIdentifiable {
    var id: String {
        return generateStepIdentifier()
    }
}
