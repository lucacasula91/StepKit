import SwiftUI

struct StepView: View {
    var model: StepModel
    @State var isCompleted: Bool = false
    @State var isExpanded: Bool = true
    @EnvironmentObject var currentStepHolder: CurrentStepHolder
    
    var body: some View {
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
        let model = StepModel(title: "Step 1",
                              subtitle: "Add all powder ingredients",
                              description: "In a bowl put the flour, the salt and the yeast.\nYou can use dry or instant yeast.")
        
        let model1 = StepModel(title: "Step 1",
                               subtitle: "Add all powder ingredients",
                               description: "In a bowl put the flour, the salt and the yeast.\nYou can use dry or instant yeast.",
                               action: .timer(seconds: 2))
        VStack {
            StepView(model: model)
            StepView(model: model1)
        }
        .preferredColorScheme(.dark)
        .environmentObject(currentStepHolder)
        .onAppear {
            currentStepHolder.currentStep = [model.id, model1.id]
        }
    }
}
