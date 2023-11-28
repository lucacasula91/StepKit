import SwiftUI

internal struct TitleAndSubtitle: View {
    
    // MARK: - Public Properties
    public var title: String
    public var subtitle: String?
    public var isCompleted: Bool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .proxyFont(.title3, bold: true)
                        
                    Spacer()
                    CompletedMark(isVisible: isCompleted)
                        .layoutPriority(1)
                }
                if let subtitle = subtitle {
                    Text(subtitle)
                        .proxyFont(.headline)
                }
            }
            .foregroundColor(.primary)
            Spacer()
        }
        
    }
}

struct TitleAndSubtitle_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
            TitleAndSubtitle(title: "My Title", subtitle: "My Subtitle", isCompleted: false)
            TitleAndSubtitle(title: "My Title", subtitle: "My Subtitle", isCompleted: true)

        }
    }
}
