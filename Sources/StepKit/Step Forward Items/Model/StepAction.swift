import SwiftUI

/// Specify the behavior that guide the step forward flow.
public enum StepAction: Codable, StepIdentifiable {

    case button(title: String = "Next", completed: Bool? = nil, identifier: String? = nil)

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

    public var completed: Bool {

        get {
            switch self {
            case .button(_, let completed, _):
                return completed ?? false

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

extension StepAction: Equatable {
    public static func ==(lhs: StepAction, rhs: StepAction) -> Bool {
        return lhs.id == rhs.id
    }
}

//extension StepAction {
//    public init(from decoder: any Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        var allKeys = ArraySlice(container.allKeys)
//        guard let onlyKey = allKeys.popFirst(), allKeys.isEmpty else {
//            throw DecodingError.typeMismatch(StepAction.self, DecodingError.Context.init(codingPath: container.codingPath, debugDescription: "Invalid number of keys found, expected one.", underlyingError: nil))
//        }
//        switch onlyKey {
//        case .button:
//            let nestedContainer = try container.nestedContainer(keyedBy: StepAction.ButtonCodingKeys.self, forKey: .button)
//
//            let title = try nestedContainer.decode(String.self, forKey: StepAction.ButtonCodingKeys.title)
//            let completed = try nestedContainer.decodeIfPresent(Bool.self, forKey: StepAction.ButtonCodingKeys.completed) ?? false
//            let identifier = try? nestedContainer.decodeIfPresent(String.self, forKey: StepAction.ButtonCodingKeys.identifier)
//
//            self = StepAction.button(title: title, completed: completed, identifier: identifier)
//
//        default: fatalError()
//            //        case .checkBox:
//            //            let nestedContainer = try container.nestedContainer(keyedBy: StepAction.CheckBoxCodingKeys.self, forKey: .checkBox)
//            //            self = StepAction.checkBox(title: try nestedContainer.decode(String.self, forKey: StepAction.CheckBoxCodingKeys.title))
//            //        case .checkBoxGroup:
//            //            let nestedContainer = try container.nestedContainer(keyedBy: StepAction.CheckBoxGroupCodingKeys.self, forKey: .checkBoxGroup)
//            //            self = StepAction.checkBoxGroup(items: try nestedContainer.decode([String].self, forKey: StepAction.CheckBoxGroupCodingKeys.items))
//            //        case .timer:
//            //            let nestedContainer = try container.nestedContainer(keyedBy: StepAction.TimerCodingKeys.self, forKey: .timer)
//            //            self = StepAction.timer(seconds: try nestedContainer.decode(TimeInterval.self, forKey: StepAction.TimerCodingKeys.seconds), notification: try nestedContainer.decodeIfPresent(TimerNotification.self, forKey: StepAction.TimerCodingKeys.notification))
//            //        case .stepper:
//            //            let nestedContainer = try container.nestedContainer(keyedBy: StepAction.StepperCodingKeys.self, forKey: .stepper)
//            //            self = StepAction.stepper(total: try nestedContainer.decode(Int.self, forKey: StepAction.StepperCodingKeys.total), title: try nestedContainer.decode(String.self, forKey: StepAction.StepperCodingKeys.title))
//        }
//    }
//}
