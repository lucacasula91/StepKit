import SwiftUI

/// Represent a completion mark that consist in a **Completed** text followed by a green check mark.
///
/// CompletedMark view expose the `isVisible` boolean parameter with drives it's visibility.
internal struct CompletedMark: View {
    var isVisible: Bool
    
    public var body: some View {
        if isVisible {
            VStack {
                HStack {
                    Text("Completed")
                        .proxyFont(.body, bold: true)
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
        }
    }
}

struct CompletedMark_Previews: PreviewProvider {
    static var previews: some View {
        CompletedMark(isVisible: true)
    }
}
