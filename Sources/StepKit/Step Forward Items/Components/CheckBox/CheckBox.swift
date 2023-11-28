import SwiftUI

/// Represent a single checkbox element.
internal struct CheckBox: View {
    public var title: String = "Mark as completed"
    public var whenCompleted: () -> Void
    @State var isChecked: Bool = false
    
    var body: some View {
        HStack {
            
            Text(title)
                .foregroundColor(.primary)
                .strikethrough(isChecked)
                .proxyFont(.body, bold: true)
            
            Button(action: {
                self.isChecked.toggle()
                if isChecked {
                    whenCompleted()
                }
            }) {
                Image(systemName: isChecked ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
            .frame(width: 44, height: 44)
            .disabled(isChecked)
        }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(title: "Mark as completed", whenCompleted: {})
    }
}
