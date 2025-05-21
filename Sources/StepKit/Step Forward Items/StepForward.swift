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
            
        case .customTimer(_, _):
            
            CustomTimerView(timerName: "Timer pasta") {
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


import SwiftUI

struct ExpandableView: View {
    @State private var expanded = false

    var body: some View {
        HStack {
            if expanded {
                content
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue.opacity(0.2))
                    .animation(.easeInOut, value: expanded)
            } else {
                content
                    .fixedSize()
                    .padding()
                    .background(Color.green.opacity(0.2))
                    .animation(.easeInOut, value: expanded)
            }
        }
        .frame(maxHeight: 100) // opzionale, solo per controllo verticale
        .border(Color.gray)
    }

    var content: some View {
        Button(action: {
            expanded.toggle()
        }) {
            Text(expanded ? "Collapse" : "Expand")
                .padding(.horizontal)
        }
    }
}



struct StepForward_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StepForward(type: .customTimer(identifier: nil, notification: nil)) { }
          
        }
    }
}
