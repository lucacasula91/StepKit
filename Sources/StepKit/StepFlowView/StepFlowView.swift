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
        .onAppear() {
            self.populateCurrentStepHolder(for: self.steps)
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

    private func populateCurrentStepHolder(for steps: [Step]) {
        let stepsToHold = steps
            .filter({ $0.action.completed == false })
            .compactMap { $0.id }

        self.currentStepHolder.currentStep = stepsToHold
    }
}

struct StepFlowView_Previews: PreviewProvider {
    static var previews: some View {
        
        let step1 = Step(title: "Add all powder ingredients",
                         description: "In a bowl put the flour, the salt and the yeast. You can use dry or instant yeast.\n\nMix all the powdered ingredients.",
                         action: .button(completed: true))

        let step2 = Step(title: "Step 2",
                         subtitle: "Add all liquid ingredients",
                         description: "Now add the 2 cups of milk and a table spoon of lemon juice.",
                         action: .checkBox(item: CheckBoxItem(title: "Mark as completed", completed: false)))

        let step3 = Step(title: "Step 3",
                         subtitle: "Bake on",
                         description: "Put the cake in the oven with a temperature of 180° degrees for about 35 minutes.",
                         action: .timer(seconds: 25, completedSeconds: 22))

        let step4 = Step(title: "Step 4",
                         subtitle: "Set in plate",
                         description: "Put the cake in a plate and add some powdered sugar on top.",
                         action: .checkBoxGroup(items: [CheckBoxItem(title: "Plate the cake", completed: false), CheckBoxItem(title: "Add powder sugar on top", completed: true)]))

        ScrollView(showsIndicators: true) {
            VStack(spacing: 16) {
                StepFlowView(steps: [step1, step2, step4, step3])
            }
            .padding()
        }
        
    }
}
