import SwiftUI

/// Describe a grouped CheckBox view.
internal struct CheckBoxGroup: View {
    
    private struct IdentifiableString {
        var id = UUID()
        var text: String
    }
    
    // MARK: - Private Properties
    @State private var completedItems: [CheckBoxItem] = []
    private var items: [CheckBoxItem]

    // MARK: - Public Properties
    public var whenCompleted: () -> Void

    // MARK: - Initialization Method
    init(items: [CheckBoxItem] = [CheckBoxItem(title: "Mark as completed")], whenCompleted: @escaping () -> Void) {
        self.items = items
        self.whenCompleted = whenCompleted
    }
    
    var body: some View {
        VStack(alignment: .trailing) {

            ForEach(self.items, id: \.title) { item in

                CheckBox(title: item.title, completed: item.completed ?? false, whenCompleted: {
                    completedItems.append(item)

                    let allItemsCompleted = completedItems.count == items.count
                    if allItemsCompleted {
                        whenCompleted()
                    }
                })
            }
        }
        .padding(12)
        .background(Material.thin)
        .cornerRadius(8)
        .onAppear() {
            self.completedItems = items.filter { ($0.completed ?? false) == true }
        }
    }
}

struct CheckBoxGroup_Previews: PreviewProvider {
    static var previews: some View {

        let item1 = CheckBoxItem(title: "First item", completed: true)
        let item2 = CheckBoxItem(title: "Second item", completed: false)
        let item3 = CheckBoxItem(title: "Third item", completed: false)

        CheckBoxGroup(items: [item1, item2, item3]) { }
    }
}
