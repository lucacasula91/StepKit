import XCTest

@testable import StepKit
final class StepFlowViewTests: XCTestCase {

    func test_StepFlowView_Initialization_Json() throws {
        let jsonString = """
[
  {
    "title": "Step 1",
    "subtitle": "My Subtitle",
    "description": "My Description",
    "action": {
      "button": {
        "title": "Next",
        "completed": false
      }
    }
  },
  {
    "title": "Step 2",
    "subtitle": "My Subtitle",
    "description": "My Description",
    "action": {
      "timer": {
        "seconds": 120
      }
    }
  }
]
"""
       
        let stepFlowView = try StepFlowView(data: jsonString.data(using: .utf8)!)
        XCTAssertNoThrow(stepFlowView)
        XCTAssertEqual(stepFlowView.steps.count, 2)
    }
    
    func test_StepFlowView_Initialization_NotValid_Json() throws {
        let jsonString = """
[
  {
    "title": "Step 1",
    "subtitle": "My Subtitle",
    "description": "My Description",
    "action": {
      "buttons": {
        "title": "Next"
      }
    }
  },
  {
    "title": "Step 2",
    "subtitle": "My Subtitle",
    "description": "My Description",
    "action": {
      "countDown": {
        "seconds": 120
      }
    }
  }
]
"""
       
        XCTAssertThrowsError(try StepFlowView(data: jsonString.data(using: .utf8)!), "Expected to throw .invalidJsonData") { (error) in
            XCTAssertEqual(error as? StepKitError, StepKitError.invalidJsonData)
        }
    }
    
}
