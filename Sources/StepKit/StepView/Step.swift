import UIKit

/// Describe the content of a specific step.
///
/// By default action property i setted to .button(title: "Next")
public struct Step: Codable, Identifiable {
    
    // MARK: - Public Properties

    /// Unique identifier that represent a specific step.
    public var id: UUID = UUID()
    
    /// Represent the title of a specific step.
    public var title: String
    
    /// Represent the subtitle of a specific step.
    ///
    /// This property accept an `Optional` string value. Subtitle can be omitted by providing a `nil` value.
    public var subtitle: String?
    
    /// Represent the description of a specific step.
    public var description: String
    
    /// Represent the action type that should be used in order to mark a step as completed.
    ///
    /// By default `action` value is setted to `.button()`.
    public var action: StepAction = .button()
    
    // MARK: - Initialization Method
    init(title: String, subtitle: String? = nil, description: String, action: StepAction = .button()) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.action = action
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case description
        case action
    }
}
