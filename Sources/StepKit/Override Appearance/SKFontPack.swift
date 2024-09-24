import SwiftUI

/// Represent the information needed to override StepKit font.
public struct SKFontPack {
    
    // MARK: - Public Properties
    
    /// Bundle that contains font files.
    public var bundle: Bundle

    /// The `SKFont` instance that represent a font in regular style.
    public var regularFont: SKFont

    /// The `SKFont` instance that represent a font in bold style.
    public var boldFont: SKFont
    
    // MARK: - Initialization Method
    
    /// Creates and returns a new instance of `SKFontPack` for the provided info.
    /// - Parameters:
    ///   - bundle: Bundle that contains font files.
    ///   - regularFont: The SKFont instance that represent a font in regular style.
    ///   - boldFont: The SKFont instance that represent a font in bold style.
    public init(bundle: Bundle, regularFont: SKFont, boldFont: SKFont) {
        self.bundle = bundle
        self.regularFont = regularFont
        self.boldFont = boldFont
    }
}
