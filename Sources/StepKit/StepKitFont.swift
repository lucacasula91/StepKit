import SwiftUI

internal struct StepKitFont: ViewModifier {
    var style: Font.TextStyle
    var bold: Bool
    var size: CGFloat
    var overridedFont: String?
    
    init(style: Font.TextStyle, bold: Bool) {
        self.style = style
        self.bold = bold
        
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

        if let fontPack = StepKitAppearance.proxy.fontPack {
            overridedFont = bold ? fontPack.boldFont.postScriptName : fontPack.regularFont.postScriptName
        }

    }
    
    func body(content: Content) -> some View {
        if let _overridedFont = overridedFont {
            return content.font(.custom(_overridedFont, size: size, relativeTo: style))
        } else {
            return content.font(.system(style).weight(bold ? .bold : .regular))
        }
    }
}

extension View {
    func proxyFont(_ style: Font.TextStyle = .body, bold: Bool = false) -> some View {
        modifier(StepKitFont(style: style, bold: bold))
    }
}

