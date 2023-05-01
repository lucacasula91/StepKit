import SwiftUI

struct StepView: View {
    var model: StepModel
    @State var isCompleted: Bool = false
    @State var isExpanded: Bool = true
    
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
        .preferredColorScheme(.dark)
    }
}
