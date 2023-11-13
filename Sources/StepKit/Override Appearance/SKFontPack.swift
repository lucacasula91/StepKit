import SwiftUI

/// Represent the information needed to override StepKit font.
public struct SKFontPack {
    
    // MARK: - Public Properties
    /// Bundle instance that contains font files.
    public var bundle: Bundle
    
    
    public var regularFont: SKFont
    public var boldFont: SKFont
    
}
