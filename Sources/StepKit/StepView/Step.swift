import UIKit

/// Describe the content of a specific step.
///
/// By default action property i setted do .button()
struct Step: Codable, Identifiable {
    
    // MARK: - Public Properties
    public var id = UUID()
    private(set) var title: String
    private(set) var subtitle: String?
    private(set) var description: String
    private(set) var action: StepAction = .button()
    
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
