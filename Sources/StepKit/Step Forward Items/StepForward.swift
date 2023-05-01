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
            
        case .timer(let seconds):
            TimerView(seconds: seconds, whenCompleted: {
                onCompletion()
            })
        }
    }
}

struct ActionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            StepForward(type: .button(title: "Next")) { }
            StepForward(type: .checkBox(title: "Single task")) { }
            StepForward(type: .checkBoxGroup(items: ["First item group", "Seconds item group"])) { }

            StepForward(type: .timer(seconds: 3)) { }
        }
    }
}
