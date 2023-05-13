import SwiftUI

/// Describe the UI of a specific ``Step`` object.
public struct StepView: View {
    
    // MARK: - Public Properties
    public var model: Step

    // MARK: - Private Properties
    @State private var isCompleted: Bool = false
    @State private var isExpanded: Bool = true
    
    // MARK: - Public Properties
    @EnvironmentObject var currentStepHolder: CurrentStepHolder
    
    public var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
            
            VStack(alignment: .leading) {
                TitleAndSubtitle(title: model.title, subtitle: model.subtitle, isCompleted: isCompleted)
                    .layoutPriority(2)
                
                if isExpanded {
                    Text(model.description)
                        .font(.body)
                        .padding(.top, 2)
                        .foregroundColor(.secondary)
                        .layoutPriority(1)
                }
                
                if isCompleted == false {
                    HStack {
                        Spacer()
                        StepForward(type: model.action) {
                            isExpanded.toggle()
                            isCompleted.toggle()
                            if isCompleted {
                                currentStepHolder.removeFirst()
                            }
                        }
                    }
                    .padding(.top)
                }
            }
            .padding(16)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(16)
            .onTapGesture {
                if isCompleted {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
            }
        }
        .disabled(isCompleted ? false : currentStepHolder.currentStep.first != self.model.id)
        .opacity(currentStepHolder.currentStep.first != self.model.id ? (isCompleted && isExpanded ? 1 : 0.4) : 1)
    }
}

struct StepView_Previews: PreviewProvider {

    static var previews: some View {
        let currentStepHolder = CurrentStepHolder()
        let model = Step(title: "Milk and yeast",
                         description: "Heat the milk until it is warm but not hot, about 90 degrees.\nIn a large bowl, combine it with the yeast. Stir lightly, and let sit until the mixture is foamy, about 5 minutes.",
                         action: .timer(seconds: 300, notification: TimerNotification(title: "Milk and yeast completed", subtitle: "Let's jump to the next step")))
        
        let model1 = Step(title: "Step 1",
                               subtitle: "Add all powder ingredients",
                               description: "In a bowl put the flour, the salt and the yeast.\nYou can use dry or instant yeast.",
                               action: .timer(seconds: 2))
        VStack {
            StepView(model: model)
            StepView(model: model1)
        }
        .environmentObject(currentStepHolder)
        .onAppear {
            currentStepHolder.currentStep = [model.id, model1.id]
        }
    }
}
