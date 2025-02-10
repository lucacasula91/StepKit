import SwiftUI

/// Represent the UI of a specific ``Step`` array object.
public struct StepFlowView: View {
    
    // MARK: - Public Properties
    public var steps: [Step]

    @StateObject var currentStepHolder = CurrentStepHolder()
    
    // MARK: - Initialization Methods
    public init(steps: [Step]) {
        self.steps = steps
        self.injectProxyAppearance()
    }

    public init(steps: [Step], userDefaults: UserDefaults) {

        var output = [Step]()

        for step in steps {
            let isCompleted = userDefaults.bool(forKey: step.id)

            var stepAction = step.action
            stepAction.completed = isCompleted

            let newStep = Step(title: step.title,
                               subtitle: step.subtitle,
                               description: step.description, action: stepAction)
            output.append(newStep)

        }

        self.steps = output
        self.injectProxyAppearance()

    }

    public init(data: Data) throws {
        do {
            let steps = try JSONDecoder().decode([Step].self, from: data)
            self.steps = steps
            self.injectProxyAppearance()

        } catch {
            throw StepKitError.invalidJsonData
        }
    }
    
    public var body: some View {
        ScrollView() {
            ForEach(steps, id: \.id) { model in
                StepView(model: model)
                Spacer(minLength: 20)
            }
        }
        .task {
            let stepsToHold = steps
                .filter({ $0.completed == false || $0.completed == nil })
                .compactMap { $0.id }

            self.currentStepHolder.currentStep = stepsToHold
        }
        .environmentObject(currentStepHolder)
    }
    
    private func injectProxyAppearance() {
        if let bundle = StepKitAppearance.proxy.fontPack?.bundle {
            
            if let regularFont = StepKitAppearance.proxy.fontPack?.regularFont {
                let fontURL = bundle.url(forResource: regularFont.fileName,
                                         withExtension: regularFont.fileExtension)
                                            
                CTFontManagerRegisterFontsForURL(fontURL! as CFURL, .process, nil)
            }
            
            if let boldFont = StepKitAppearance.proxy.fontPack?.boldFont {
                let fontURL = bundle.url(forResource: boldFont.fileName,
                                         withExtension: boldFont.fileExtension)
                                            
                CTFontManagerRegisterFontsForURL(fontURL! as CFURL, .process, nil)
            }
            
        }
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
        
        ScrollView(showsIndicators: true) {
            VStack(spacing: 16) {
                StepFlowView(steps: [step1, step2, step3, step4])
            }
            .padding()
        }
        
    }
}
