import SwiftUI

struct StepView: View {
    var model: StepModel
    @State var isCompleted: Bool = false
    
    var body: some View {
        ZStack {
            Color(UIColor.systemBackground)
            
            VStack(alignment: .leading) {
                HStack {
                    TitleAndSubtitle(title: model.title, subtitle: model.subtitle)
                    CompletedMark(isVisible: isCompleted)
                }
                
                if isCompleted == false {
                    Text(model.description)
                        .font(.body)
                        .padding(.top, 1)
                        .foregroundColor(.secondary)
                    
                    HStack {
                        Spacer()
                        switch model.action {
                        case .button(let title):
                            Button(title ?? "Next") {
                                withAnimation {
                                    isCompleted.toggle()
                                }
                            }
                            .font(.headline)
                            
                        case .checkBox(let title):
                            Button(title ?? "CheckBox") {
                                
                            }
                            
                        case .timer(let seconds):
                            TimerView(seconds: seconds, whenCompleted: {
                                isCompleted.toggle()
                            })
                        }
                    }
                    .padding(.top)
                }
                
            }
            .padding(16)
            .background(Color(UIColor.systemGray6))
            .cornerRadius(16)
            
        }
    }
}

struct StepView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        Group {
            let model = StepModel(title: "Step 1",
                                  subtitle: "Add all powder ingredients",
                                  description: "In a bowl put the flour, the salt and the yeast.\nYou can use dry or instant yeast.")
            StepView(model: model)
            
            let model1 = StepModel(title: "Step 1",
                                   subtitle: "Add all powder ingredients",
                                   description: "In a bowl put the flour, the salt and the yeast.\nYou can use dry or instant yeast.",
                                   action: .timer(seconds: 2))
            StepView(model: model1)
            
        }
    }
}
