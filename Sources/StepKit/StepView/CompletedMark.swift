import SwiftUI

/// Represent a completion mark that consist in a **Completed** text followed by a green check mark.
///
/// CompletedMark view expose the `isVisible` boolean parameter with drives it's visibility.
struct CompletedMark: View {
    var isVisible: Bool
    
    var body: some View {
        if isVisible {
            VStack {
                HStack {
                    Text("Completed")
                        .fontWeight(.bold)
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
