import SwiftUI

internal struct StepKitFont: ViewModifier {
    var style: Font.TextStyle
    var size: CGFloat
    var fontName: String

    init(style: Font.TextStyle) {
        self.style = style
        
        switch style {
        case .largeTitle: size = 34
        case .title: size = 32
        case .title2: size = 27
        case .title3: size = 22
        case .headline: size = 16
        case .subheadline: size = 14
        case .body: size = 17
        case .callout: size = 14
        case .footnote: size = 14
        case .caption: size = 14
        case .caption2: size = 12
        default: size = 17
        }
        
        fontName = StepKit.appearance.fontName ?? "SF Pro"
    }
    
    func body(content: Content) -> some View {
        content.font(.custom(fontName, size: size, relativeTo: style))
    }
}

extension View {
    func proxyFont(_ style: Font.TextStyle = .body) -> some View {
        modifier(StepKitFont(style: style))
    }
}

