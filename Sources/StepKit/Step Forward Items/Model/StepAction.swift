import SwiftUI

/// Specify the behavior that guide the step forward flow.
public enum StepAction: Codable, StepIdentifiable {

    /// Button object that allow to make a step forward.
    ///
    /// By default `title` property is setted to **Next** string.
    ///
    /// - parameter title: The title to assign to the button.
    case button(title: String = "Next")
    
    /// Checkbox button that allow to mark a step as completed.
    ///
    /// By default `title` property is setted to **Mark as completed** string.
    ///
    /// - parameter title: The title to assign to the checkbox.
    case checkBox(title: String = "Mark as completed")
    
    /// Group of CheckBox buttons that allow to mark a step as completed once each checkbox has been flagged.
    ///
    /// You can specify multiple items by populating the `items` property with a String array. Each element of the array it's rendered as single CheckBox element.
    ///
    /// - parameter items: Array of String that represent each checkbox to present.
    case checkBoxGroup(items: [String])
    
    /// Timer specified in second that allow to make a step forward once the countdown is completed.
    ///
    /// Once the count down is completed the text **Completed** is shown instead of the counter. If TimerNotification object has been specified user can get a LocalNotification once the count down is completed.
    ///
    /// - parameter seconds: Amount of seconds specified in TimeInterval object.
    /// - parameter notification: Model that represent the notification content that should be prompted once the count down is completed.
    case timer(seconds: TimeInterval, notification: TimerNotification? = nil)
    
    /// Stepper counter that allow to track repetitions in order to mark a step as completed.
    ///
    /// By default `title` property is setted to **Repetitions** string.
    ///
    /// - parameter total: The amount of repetitions to perform.
    /// - parameter title: The title to assign to the checkbox.
    case stepper(total: Int, title: String = "Repetitions")

    // MARK: - Hashable Logic
    public func generateStepIdentifier() -> String {

        switch self {
        case .button(let title): 
            let stepIdentifier = StepIdentifierProvider(elements: "button", title).stepIdentifier
            return stepIdentifier

        case .checkBox(let title):
            let stepIdentifier = StepIdentifierProvider(elements: "checkBox", title).stepIdentifier
            return stepIdentifier

        case .checkBoxGroup(let items):
            let stepIdentifier = StepIdentifierProvider(elements: "checkBoxGroup", items.joined()).stepIdentifier
            return stepIdentifier

        case .timer(let seconds, let notification):
            let stepIdentifier = StepIdentifierProvider(elements: "timer", "\(seconds)", notification?.id ?? "").stepIdentifier
            return stepIdentifier

        case .stepper(let total, let title):
            let stepIdentifier = StepIdentifierProvider(elements: "stepper", "\(total)", title).stepIdentifier
            return stepIdentifier
        }
    }

}
