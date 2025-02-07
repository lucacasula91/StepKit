import SwiftUI

/// Describe the UI of a specific ``Step`` object.
internal struct StepView: View {

    // MARK: - Public Properties
    public var model: Step
    @State var isCompleted: Bool
    @State var isExpanded: Bool

    init(model: Step) {
        self.model = model

        let completed = self.model.completed ?? false
        self.isCompleted = completed

        if completed {
            self.isExpanded = false
        } else {
            self.isExpanded = true
        }
    }

    // MARK: - Public Properties
    @EnvironmentObject var currentStepHolder: CurrentStepHolder

    public var body: some View {

        VStack(alignment: .leading) {
            TitleAndSubtitle(title: model.title,
                             subtitle: model.subtitle,
                             isCompleted: isCompleted)
                .layoutPriority(2)

            if isExpanded {
                Text(model.description)
                    .proxyFont(.body)
                    .padding(.top, 2)
                    .foregroundColor(.secondary)
                    .layoutPriority(1)
            }

            if isCompleted == false || isExpanded {
                HStack {
                    Spacer()
                    StepForward(type: model.action) {
                        isExpanded.toggle()
                        isCompleted.toggle()
                        if isCompleted {
                            currentStepHolder.removeFirst()
                        }
                    }
                    .disabled(isCompleted)
                }
            }
        }
        .padding(16)
        .background(Material.thick, in: RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
            if isCompleted {
                withAnimation {
                    isExpanded.toggle()
                }
            }
        }

        .disabled(isCompleted ? false : currentStepHolder.currentStep.first != self.model.id)
        .opacity(currentStepHolder.currentStep.first != self.model.id ? (isCompleted && isExpanded ? 1 : 0.5) : 1)
    }

}

struct StepView_Previews: PreviewProvider {

    static var previews: some View {

        let jsonString1 = """
{
  "title": "Prepare your ingredients",
  "description": "Take 200 cl. of milk.",
  "action": {
    "button": {
      "title": "Next"
    }
  }
}
"""
        let stepModel = try! JSONDecoder().decode(Step.self, from: jsonString1.data(using: .utf8)!)

        let jsonString2 = """
{
  "title": "Milk and yeast",
  "description": "Heat the milk until it is warm but not hot, about 90 degrees.\\nIn a large bowl, combine it with the yeast. Stir lightly, and let sit until the mixture is foamy, about 5 minutes.",
  "action": {
    "timer": {
      "seconds": 3,
      "notification": {
        "title": "Step 1 completed",
        "subtitle": "Let's jump to the next step"
      }
    }
  
  }
}
"""
        let stepModel2 = try! JSONDecoder().decode(Step.self, from: jsonString2.data(using: .utf8)!)




        let model2 = Step(title: "Step 1",
                          subtitle: "Add all powder ingredients",
                          description: "In a bowl put the flour, the salt and the yeast.\nYou can use dry or instant yeast.",
                          action: .timer(seconds: 2))

        let currentStepHolder = CurrentStepHolder()


        VStack {
            StepView(model: stepModel)
            StepView(model: stepModel2)
            StepView(model: model2)
        }
        .environmentObject(currentStepHolder)
        .onAppear {

            let ids: [String] = [stepModel, stepModel2, model2].filter { step in
                return step.completed == false
            }.map { $0.id }
            currentStepHolder.currentStep = ids
        }
    }
}
