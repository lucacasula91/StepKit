import UIKit

/// Describe all the thrownable errors in StepKit.
enum StepKitError: Error {
    
    /// It is throwed when trying to initialize FlowView passing an invalid json object.
    case invalidJsonData
}
