import SwiftUI

/// Represent the type of Forward action to assign to a specific StepView.
internal struct StepForward: View {
    var type: StepAction
    var onCompletion: () -> Void
    
    var body: some View {
        
        switch type {
        case .button(let title, let completed, _):
            ButtonAction(title: title, completed: completed) {
                withAnimation {
                    onCompletion()
                }
            }
            
        case .checkBox(let item):
            CheckBox(title: item.title, completed: item.completed ?? false) {
                withAnimation {
                    onCompletion()
                }
            }

        case .checkBoxGroup(let items):
            CheckBoxGroup(items: items, whenCompleted: {
                withAnimation {
                    onCompletion()
                }
            })
            
        case .timer(let seconds, let completedSeconds, let identifier, let timerNotification):
            let request = NotificationGenerator().createNotificationRequest(from: timerNotification, with: seconds)
            
            TimerView(seconds: seconds, completedSeconds: completedSeconds ?? 0, notificationRequest: request) {
                withAnimation {
                    onCompletion()
                }
            }
        
        case .stepper(let total, let title):
            StepperAction(total: total, title: title, whenCompleted: {
                withAnimation {
                    onCompletion()
                }
            })
        }
    }
}
struct StepForward_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StepForward(type: .button()) { }
            
            StepForward(type: .checkBox(item: CheckBoxItem(title: "First item"))) { }
            StepForward(type: .checkBoxGroup(items: [CheckBoxItem(title: "First item"), CheckBoxItem(title: "Second item item")])) { }

            StepForward(type: .timer(seconds: 3)) { }
            
            StepForward(type: .stepper(total: 7, title: "Rounds")) { }
        }
    }
}
