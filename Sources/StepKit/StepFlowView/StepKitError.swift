import UIKit

/// Describe all the thrownable errors in StepKit.
public enum StepKitError: Error {
    
    /// It is throwed when trying to initialize FlowView passing the Data representation of an invalid json object.
    case invalidJsonData
}
