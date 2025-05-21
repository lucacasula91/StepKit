import SwiftUI

/// Describe the UI of a specific ``Step`` object.
internal struct StepView: View {

    // MARK: - Public Properties
    public var model: Step
    @State var isCompleted: Bool
    @State var isExpanded: Bool

    init(model: Step) {
        self.model = model

        let completed = self.model.action.completed
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

                if isCompleted == false {
                    HStack {
                        Spacer(minLength: 1)
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
    "customTimer": {
      "identifier": "Next"
    }
  }
}
"""
        let stepModel = try! JSONDecoder().decode(Step.self, from: jsonString1.data(using: .utf8)!)


        let currentStepHolder = CurrentStepHolder()

        StepFlowView(steps: [stepModel])
        .environmentObject(currentStepHolder)
        .onAppear {

            let ids: [String] = [stepModel].filter { step in
                return step.action.completed == false
            }.map { $0.id }
            currentStepHolder.currentStep = ids
        }
    }
}
