import SwiftUI

struct TitleAndSubtitle: View {
    
    // MARK: - Public Properties
    public var title: String
    public var subtitle: String?
    public var isCompleted: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .font(.title3)
                    .fontWeight(.bold)
                    Spacer()
                    CompletedMark(isVisible: isCompleted)
                        .layoutPriority(1)
                }
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.headline)
                }
            }
            .foregroundColor(.primary)
            Spacer()
        }
    }
}


struct TitleAndSubtitle_Previews: PreviewProvider {
    static var previews: some View {
        TitleAndSubtitle(title: "My Title", subtitle: "My Subtitle", isCompleted: true)
    }
}
