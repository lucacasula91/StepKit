import SwiftUI

/// Describe a grouped CheckBox view.
internal struct CheckBoxGroup: View {
    
    private struct IdentifiableString {
        var id = UUID()
        var text: String
    }
    
    // MARK: - Private Properties
    @State private var completedItems: [UUID] = []
    private var items: [IdentifiableString]
    
    // MARK: - Public Properties
    public var whenCompleted: () -> Void

    // MARK: - Initialization Method
    init(items: [String] = ["Mark as completed"], whenCompleted: @escaping () -> Void) {
        self.items = items.map { IdentifiableString(text: $0) }
        self.whenCompleted = whenCompleted
    }
    
    var body: some View {
        VStack(alignment: .trailing) {
            ForEach(self.items, id: \.id) { item in
                CheckBox(title: item.text, whenCompleted: {
                    completedItems.append(item.id)
                    
                    if completedItems.count == items.count {
                        whenCompleted()
                    }
                })
            }
        }
        .padding(12)
        .background(Material.thin)
        .cornerRadius(8)
    }
}

struct CheckBoxGroup_Previews: PreviewProvider {
    static var previews: some View {
        CheckBoxGroup(items: ["First item", "Second item", "Third item"]) { }
    }
}
