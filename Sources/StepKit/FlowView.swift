import SwiftUI

struct FlowView: View {
    var steps: [StepModel]

    // MARK: - Initialization Methods
    init(steps: [StepModel]) {
        self.steps = steps
    }
    
    init(data: Data) throws {
        do {
            let steps = try JSONDecoder().decode([StepModel].self, from: data)
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
    }
}

struct FlowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let step1 = StepModel(title: "Step 1", subtitle: "Add all powder ingredients",
                              description: "In a bowl put the flour, the salt and the yeast. You can use dry or instant yeast.\n\nMix all the powdered ingredients.", action: .button())
        
        let step2 = StepModel(title: "Step 2", subtitle: "Add all liquid ingredients", description: "Now add the 2 cups of milk and a table spoon of lemon juice.", action: .button())
        let step3 = StepModel(title: "Step 3", subtitle: "Bake on", description: "Put the cake in the oven with a temperature of 180° degrees for about 35 minutes.", action: .timer(seconds: 10))
        FlowView(steps: [step1, step2, step3])
    }
}
