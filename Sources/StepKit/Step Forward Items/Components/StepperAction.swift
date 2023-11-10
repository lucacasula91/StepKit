import SwiftUI

/// Represent a stepper element with a button to increment the current step.
internal struct StepperAction: View {
    // MARK: - Public Properties
    public var total: Int
    public var title: String
    public var whenCompleted: () -> Void
    
    // MARK: - Private Properties
    @State private var currentRepeat: Int = 1
    @State private var isCompleted: Bool = false
    @State private var markedAsDone: Bool = false

    // MARK: - View body
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .fontWeight(.bold)
            HStack(spacing: 30) {
                HStack(spacing: 2) {
                    Text("\(currentRepeat)")
                        .fontWeight(.bold)
                    Text(" of ")
                    Text("\(total)")
                        .fontWeight(.bold)
                }
                Button(action: {
                    guard isCompleted == false else {
                        whenCompleted()
                        return
                    }
                    
                    if currentRepeat == total && markedAsDone == false {
                        markedAsDone = true
                        isCompleted = true
                        return
                    }
                    currentRepeat += 1
                    
                }, label: {
                    Text((currentRepeat >= total) ? "Done" : "Next")
                        .fontWeight(isCompleted ? .bold : .regular)
                })
                .disabled(markedAsDone)
                .padding(8)
            }
        }
        .padding(12)
        .background(Color(UIColor.gray))
        .cornerRadius(8)
    }
}

struct StepperAction_Previews: PreviewProvider {
    static var previews: some View {
        StepperAction(total: 7, title: "Rows", whenCompleted: {})
    }
}
