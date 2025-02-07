import SwiftUI

/// Button object that allow to make a step forward.
///
/// By default `title` property is setted to **Next** string.
///
/// - parameter title: The title to assign to the button.
internal struct ButtonAction: View {
    
    // MARK: - Public Properties
    public var title: String
    @State public var completed: Bool?
    public var whenCompleted: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                completed?.toggle()
                whenCompleted()
            }
        } label: {
            Text(title)
        }
        .padding()
        .disabled(completed ?? false)
        .proxyFont(.headline, bold: true)
    }
}

struct ButtonAction_Previews: PreviewProvider {
    static var previews: some View {
        VStack() {
            ButtonAction(title: "Next", whenCompleted: { })
            ButtonAction(title: "Next", completed: true, whenCompleted: { })
        }
    }
}
