import UIKit

/// Specify the behavior that guide the flow step forward.
enum StepAction: Codable, Equatable {

    /// Button object that allow to make a step forward.
    ///
    /// By default `title` property is setted to nil. When `nil` value is passed to `title` property the StepView object will show **Next** as default title.
    ///
    /// - parameter title: The title to assign to the button.
    case button(title: String? = nil)
    
    /// Checkbox button that allow to mark a step as completed.
    ///
    /// By default `title` property is setted to nil. When `nil` value is passed to `title` property the StepView object will show **Mark as completed** as default title.
    ///
    /// - parameter title: The title to assign to the checkbox.
    case checkBox(title: String? = nil)
    
    case checkBoxGroup(items: [String])
    
    /// Timer specified in second that allow to make a step forward once the countdown is completed.
    ///
    /// Once the count down is completed the text **Completed** is shown instead of the counter.
    case timer(seconds: TimeInterval)
}
