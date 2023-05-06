import UIKit

class NotificationGenerator {
    
    static func createNotificationRequest(from model: TimerNotification?,
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
