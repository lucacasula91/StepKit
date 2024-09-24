import SwiftUI

/// An object for customizing the appearance of every ``StepKit/StepFlowView`` items.
///
/// After creating a ``StepKit/StepKitAppearance`` object, override properties of this class to specify the appearance you want for items of ``StepKit/StepFlowView``.
public class StepKitAppearance {

    /// Static access to ``StepKit/StepKitAppearance``.
    static public var proxy = StepKitAppearance()
    private init() {}

    /// Gives you access to override fonts used in ``StepKit/StepFlowView`` views.
    ///
    /// ``StepKit`` uses both **regular** and **bold** font styles, for a better user experience provide each font style required.
    public var fontPack: SKFontPack?
}
