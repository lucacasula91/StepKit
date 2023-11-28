import SwiftUI

/// Button object that allow to make a step forward.
///
/// By default `title` property is setted to **Next** string.
///
/// - parameter title: The title to assign to the button.
internal struct ButtonAction: View {
    
    // MARK: - Public Properties
    public var title: String
    public var whenCompleted: () -> Void
    
    var body: some View {
        Button {
            withAnimation {
                whenCompleted()
            }
        } label: {
            Text(title)
        }
        .padding()
        .proxyFont(.headline, bold: true)
    }
}

struct ButtonAction_Previews: PreviewProvider {
    static var previews: some View {
        ButtonAction(title: "Next", whenCompleted: { })
    }
}
