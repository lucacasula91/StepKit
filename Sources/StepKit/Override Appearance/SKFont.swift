import SwiftUI

public struct SKFont {
    
    // MARK: - Public Properties
    public var fileName: String
    public var fileExtension: String
    public var postScriptName: String
    
    public init(fileName: String, fileExtension: String, postScriptName: String) {
        self.fileName = fileName
        self.fileExtension = fileExtension
        self.postScriptName = postScriptName
    }
}
