import XCTest

@testable import StepKit
final class FlowViewTests: XCTestCase {

    func test_FlowView_Initialization_Json() throws {
        let jsonString = """
[
  {
    "title": "Step 1",
    "subtitle": "My Subtitle",
    "description": "My Description",
    "action": {
      "button": {
        "title": "Next"
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
       
        let flowView = try FlowView(data: jsonString.data(using: .utf8)!)
        XCTAssertNoThrow(flowView)
        XCTAssertEqual(flowView.steps.count, 2)
    }
    
    func test_FlowView_Initialization_NotValid_Json() throws {
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
       
        XCTAssertThrowsError(try FlowView(data: jsonString.data(using: .utf8)!), "Expected to throw .invalidJsonData") { (error) in
            XCTAssertEqual(error as? StepKitError, StepKitError.invalidJsonData)
        }
    }
    
}
