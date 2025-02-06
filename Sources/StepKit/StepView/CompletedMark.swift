import SwiftUI

/// Represent a completion mark that consist in a **Completed** text followed by a green check mark.
///
/// CompletedMark view expose the `isVisible` boolean parameter with drives it's visibility.
internal struct CompletedMark: View {
    var isVisible: Bool
    @Environment(\.sizeCategory) var sizeCategory

    public var body: some View {
        if isVisible {

            if sizeCategory >= .extraLarge {
                VStack(spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.green)

                    Text("Completed")
                        .proxyFont(.callout, bold: true)
                }
            } else {
                HStack {
                    Text("Completed")
                        .proxyFont(.callout, bold: true)

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
