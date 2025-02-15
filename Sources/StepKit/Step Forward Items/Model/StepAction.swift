import SwiftUI

public struct CheckBoxItem: Codable {
    var title: String
    var completed: Bool?
    var identifier: String?

    public init(title: String, completed: Bool? = nil, identifier: String? = nil) {
        self.title = title
        self.completed = completed
        self.identifier = identifier
    }
}


/// Specify the behavior that guide the step forward flow.
public enum StepAction: Codable, StepIdentifiable {

    case button(title: String = "Next", completed: Bool? = nil, identifier: String? = nil)

    case checkBox(item: CheckBoxItem = CheckBoxItem(title: "Mark as completed"))

    /// Group of CheckBox buttons that allow to mark a step as completed once each checkbox has been flagged.
    ///
    /// You can specify multiple items by populating the `items` property with a String array. Each element of the array it's rendered as single CheckBox element.
    ///
    /// - parameter items: Array of String that represent each checkbox to present.
    case checkBoxGroup(items: [CheckBoxItem])

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

    public var completed: Bool {

        get {
            switch self {
            case .button(_, let completed, _):
                return completed ?? false

            case .checkBox(let item):
                return item.completed ?? false

            case .checkBoxGroup(let items):
                let itemsCompleted = items.map { $0.completed ?? false }
                return itemsCompleted.contains(false) == false

            default:
                return false
            }
        }

        set { }

    }

    // MARK: - Hashable Logic
    public func generateStepIdentifier() -> String {

        switch self {
        case .button(_, _, let identifier):
            let stepIdentifier = StepIdentifierProvider(elements: "button", identifier).stepIdentifier
            return stepIdentifier

        case .checkBox(let item):
            let stepIdentifier = StepIdentifierProvider(elements: "checkBox", item.identifier).stepIdentifier
            return stepIdentifier

        case .checkBoxGroup(let items):
           // let stepIdentifier = StepIdentifierProvider(elements: "checkBoxGroup", items.joined()).stepIdentifier
            return "stepIdentifier"

        case .timer(let seconds, let notification):
            let stepIdentifier = StepIdentifierProvider(elements: "timer", "\(seconds)", notification?.id ?? "").stepIdentifier
            return stepIdentifier

        case .stepper(let total, let title):
            let stepIdentifier = StepIdentifierProvider(elements: "stepper", "\(total)", title).stepIdentifier
            return stepIdentifier
        }
    }

}

extension StepAction: Equatable {
    public static func ==(lhs: StepAction, rhs: StepAction) -> Bool {
        return lhs.id == rhs.id
    }
}
