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
            
        case .checkBox(let title):
            CheckBox(title: title, whenCompleted: {
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
            let request = NotificationGenerator().createNotificationRequest(from: timerNotification, with: seconds)
            
            TimerView(seconds: seconds, notificationRequest: request) {
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
            
            StepForward(type: .checkBox(title: "Single task")) { }
            StepForward(type: .checkBoxGroup(items: ["First item group", "Seconds item group"])) { }
            
            StepForward(type: .timer(seconds: 3)) { }
            
            StepForward(type: .stepper(total: 7, title: "Rounds")) { }
        }
    }
}
