import SwiftUI

/// Keeps track of the current managed step during the flow.
internal class CurrentStepHolder: ObservableObject {

    // MARK: - Public Properties
    @Published public var currentStep: [String] = []


    // MARK: - Public Methods
    public func removeFirst() {
        if self.currentStep.isEmpty == false {
            self.currentStep.removeFirst()
        }
    }
}
