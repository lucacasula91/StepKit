import SwiftUI

/// An object that contains the main information about the font to proxy.
public struct SKFont {
    
    // MARK: - Public Properties
    /// The file name of the font.
    public var fileName: String

    /// The file extension of the font
    public var fileExtension: String

    /// The PostScript font name representation.
    public var postScriptName: String

    /// Creates and return a new SKFont object for the specified info.
    /// - Parameters:
    ///   - fileName: The file name of the font.
    ///   - fileExtension: The file extension of the font
    ///   - postScriptName: The PostScript font name representation.
    public init(fileName: String, fileExtension: String, postScriptName: String) {
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.postScriptName = postScriptName
    }
}
