import SwiftUI

/// Represent the type of Forward action to assign to a specific StepView.
struct StepForward: View {
    var type: StepAction
    var onCompletion: () -> Void
    
    var body: some View {
        
        switch type {
        case .button(let title):
            Button(title ?? "Next") {
                withAnimation {
                    onCompletion()
                }
            }
            .padding()
            .font(.headline)
            
        case .checkBox(let title):
            CheckBox(title: title ?? "", whenCompleted: {
                withAnimation {
                    onCompletion()
                }
            })
            
        case .checkBoxGroup(let items):
            CheckBoxGroup(items: items, whenCompleted: {
                withAnimation {
                    onCompletion()
                }
            })
            
        case .timer(let seconds, let timerNotification):
            let request = NotificationGenerator.createNotificationRequest(from: timerNotification, with: seconds)
            
            TimerView(seconds: seconds, notificationRequest: request) {
                withAnimation {
                    onCompletion()
                }
            }
        }
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StepForward(type: .button(title: "Continua")) { }
            StepForward(type: .checkBox(title: "Single task")) { }
            StepForward(type: .checkBoxGroup(items: ["First item group", "Seconds item group"])) { }

            StepForward(type: .timer(seconds: 3)) { }
        }
    }
}

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
