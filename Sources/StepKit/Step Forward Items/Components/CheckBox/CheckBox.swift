import SwiftUI

/// Represent a single checkbox element.
internal struct CheckBox: View {
    public var title: String = "Mark as completed"
    @State public var completed: Bool = false
    public var whenCompleted: () -> Void

    private let uncheckedIcon = Image(systemName: "circle")
    private let checkedIcon = Image(systemName: "checkmark.circle.fill")


    var body: some View {
        HStack {
            
            Text(title)
                .foregroundColor(.primary)
                .strikethrough(completed)
                .proxyFont(.body, bold: true)

            Button(action: {
                self.completed.toggle()
                if completed {
                    whenCompleted()
                }
            }) {

                if completed {
                    checkedIcon
                        .resizable()
                        .frame(width: 30, height: 30)
                } else {
                    uncheckedIcon
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            .frame(width: 44, height: 44)
            .disabled(completed)
        }
    }
}

struct CheckBox_Previews: PreviewProvider {
    static var previews: some View {
        CheckBox(title: "Mark as completed", whenCompleted: {})
    }
}
