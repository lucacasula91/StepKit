import UIKit

/// Describe the content of LocalNotification to present once count down is completed.
public struct TimerNotification: Codable, Equatable {
    
    /// Title of the local notification.
    public var title: String
    
    /// Subtitle of the local notification.
    public var subtitle: String
}
