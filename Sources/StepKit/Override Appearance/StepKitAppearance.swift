import SwiftUI

public class StepKitAppearance {
    private init() {}
    
    public var fontPack: SKFontPack? {
        didSet {
            if let bundle = fontPack?.bundle {
                
                if let regularFont = fontPack?.regularFont {
                    let fontURL = bundle.url(forResource: regularFont.fileName,
                                             withExtension: regularFont.fileExtension)
                                                
                    CTFontManagerRegisterFontsForURL(fontURL! as CFURL, .process, nil)
                }
                
                if let boldFont = fontPack?.boldFont {
                    let fontURL = bundle.url(forResource: boldFont.fileName,
                                             withExtension: boldFont.fileExtension)
                                                
                    CTFontManagerRegisterFontsForURL(fontURL! as CFURL, .process, nil)
                }
                
            }
        }
    }
    
    static public func proxy() -> Self {
        return StepKitAppearance() as! Self
    }
}
