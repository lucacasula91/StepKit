import Foundation

/// Describe the content of a specific step.
///
/// By default action property i setted to .button(title: "Next")
public struct Step: Codable, StepIdentifiable, Equatable {

    
    // MARK: - Public Properties

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
    /// Create a new instance of Step.
    /// - Parameters:
    ///   - title: Represent the title of a specific step.
    ///   - subtitle: Represent the subtitle of a specific step.
    ///   - description: Represent the description of a specific step.
    ///   - action: Represent the action type that should be used in order to mark a step as completed.
    init(title: String, subtitle: String? = nil, description: String, action: StepAction = .button()) {
        self.title = title
        self.subtitle = subtitle
        self.description = description
        self.action = action
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.subtitle = try container.decodeIfPresent(String.self, forKey: .subtitle)
        self.description = try container.decode(String.self, forKey: .description)

        let action = try container.decode(StepAction.self, forKey: .action)
        self.action = action
    }

    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case description
        case action
    }

    // MARK: - Public Method

    // MARK: - Hashable Logic
    public func generateStepIdentifier() -> String {
        let stepIdentifier = StepIdentifierProvider(elements: title, subtitle, description, action.id).stepIdentifier
        return stepIdentifier
    }

    // MARK: - Equatable Logic
    public static func == (lhs: Step, rhs: Step) -> Bool {
        lhs.id == rhs.id
    }
}
