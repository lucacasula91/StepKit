import UIKit

class CurrentStepHolder: ObservableObject {
    @Published var currentStep: [UUID] = [UUID()]
    
    public func removeFirst() {
        if self.currentStep.isEmpty == false {
            self.currentStep.removeFirst()
        }
    }
}
