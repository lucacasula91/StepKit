import UIKit

/// Describe the content of LocalNotification presented once count down is completed.
public struct TimerNotification: Codable, StepIdentifiable {

    /// Title of the local notification.
    public var title: String
    
    /// Subtitle of the local notification.
    public var subtitle: String

    // MARK: - StepIdentifiable Logic
    public func generateStepIdentifier() -> String {
        let stepIdentifier = StepIdentifierProvider(elements: title, subtitle).stepIdentifier
        return stepIdentifier
    }
}
