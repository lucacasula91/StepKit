import SwiftUI

struct CheckBoxGroup: View {
    struct IdentifiableString {
        var id = UUID()
        var text: String
    }
    
    private var items: [IdentifiableString]
    public var whenCompleted: () -> Void

    @State var completedItems: [UUID] = []
    
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
        .background(Color(UIColor.systemGray5))
        .cornerRadius(8)
    }
}

struct CheckBoxGroup_Previews: PreviewProvider {
    static var previews: some View {
        
        CheckBoxGroup(items: ["First item", "Second item", "Third item"]) {

        }
    }
}
