import SwiftUI

struct StepFlowView: View {
    
    // MARK: - Public Properties
    public var steps: [Step]
    @StateObject public var currentStepHolder = CurrentStepHolder()
    
    // MARK: - Initialization Methods
    init(steps: [Step]) {
        self.steps = steps
    }
    
    init(data: Data) throws {
        do {
            let steps = try JSONDecoder().decode([Step].self, from: data)
            self.steps = steps
        } catch {
            throw StepKitError.invalidJsonData
        }
    }
    
    var body: some View {
        ScrollView() {
            ForEach(steps, id: \.id) { model in
                StepView(model: model)
                Spacer(minLength: 20)
            }
        }
        .onAppear {
            let stepsToHold = steps.compactMap { $0.id }
            self.currentStepHolder.currentStep = stepsToHold
        }
        .environmentObject(currentStepHolder)
    }
        
}

struct StepFlowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let step1 = Step(title: "Add all powder ingredients",
                              description: "In a bowl put the flour, the salt and the yeast. You can use dry or instant yeast.\n\nMix all the powdered ingredients.",
                              action: .button())
        
        let step2 = Step(title: "Step 2",
                              subtitle: "Add all liquid ingredients",
                              description: "Now add the 2 cups of milk and a table spoon of lemon juice.",
                              action: .checkBox(title: "Mark as completed"))
        
        let step3 = Step(title: "Step 3",
                              subtitle: "Bake on",
                              description: "Put the cake in the oven with a temperature of 180° degrees for about 35 minutes.",
                              action: .timer(seconds: 10))
        
        let step4 = Step(title: "Step 4",
                              subtitle: "Set in plate",
                              description: "Put the cake in a plate and add some powdered sugar on top.",
                              action: .checkBoxGroup(items: ["Plate the cake", "Add powdered sugar on top"]))
        
        StepFlowView(steps: [step1, step2, step3, step4])
    }
}
