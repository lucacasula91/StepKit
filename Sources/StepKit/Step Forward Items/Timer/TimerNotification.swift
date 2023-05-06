import UIKit

/// Describe the content of LocalNotification to present once count down is completed.
struct TimerNotification: Codable, Equatable {
    
    /// Title of the local notification.
    var title: String
    
    /// Subtitle of the local notification.
    var subtitle: String
}
