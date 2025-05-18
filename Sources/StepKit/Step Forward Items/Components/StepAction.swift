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

    case checkBoxGroup(items: [CheckBoxItem])

    case timer(seconds: TimeInterval, completedSeconds: TimeInterval? = nil, identifier: String? = nil, notification: TimerNotification? = nil)

    case customTimer(identifier: String? = nil, notification: TimerNotification? = nil)

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

            case .timer(let seconds, let completedSeconds, _, _):
                return seconds == (completedSeconds ?? 0)

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
            let identifier = (items.map {$0.identifier ?? $0.title}).joined(separator: "_")
            let stepIdentifier = StepIdentifierProvider(elements: "checkBoxGroup", identifier).stepIdentifier
            return stepIdentifier

        case .timer(let seconds, _, let identifier, _):
            let stepIdentifier = StepIdentifierProvider(elements: "timer", identifier ?? "\(seconds)").stepIdentifier
            return stepIdentifier
            
        case .customTimer(let identifier, _):
            let stepIdentifier = StepIdentifierProvider(elements: "custom_timer", identifier ?? "\(UUID().uuidString)").stepIdentifier
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
