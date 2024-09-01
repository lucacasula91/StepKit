import Foundation
import UserNotifications

/// Helper class that consist in generating a local notification request providing the TimerNotification model and the TimeInterval object.
internal class NotificationGenerator {
    
    // MARK: - Public Methods
    
    /// Generate a UNNotificationRequest using the information passed.
    ///
    /// This method is optional. If you don't need to schedule a local notification just pass a nil value in `fromModel` parameter.
    /// - Parameters:
    ///   - model: TimerNotification model that descibe the notification content. This propery can be passed nil if local notification is not needed.
    ///   - timeInterval: TimeInterval object that describe when the notification should be present.
    /// - Returns: Optional UNNotificationRequest object. This property is returned as `nil` if TimerNotification object is not provided.
    public func createNotificationRequest(from model: TimerNotification?,
                                          with timeInterval: TimeInterval) -> UNNotificationRequest? {
        guard let _model = model else { return nil }
        
        let content = UNMutableNotificationContent()
        content.title = _model.title
        content.subtitle = _model.subtitle
        content.sound = UNNotificationSound.default

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        return request
    }
}
