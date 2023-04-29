import XCTest

@testable import StepKit
final class StepModelTests: XCTestCase {

    func test_StepModel_Codable_Init_Button() throws {
        
        let jsonString = """
{
  "title": "My Title",
  "subtitle": "My Subtitle",
  "description": "My Description",
  "action": {
    "button": {
      "title": "Next"
    }
  }
}
"""
        let stepModel = try JSONDecoder().decode(StepModel.self, from: jsonString.data(using: .utf8)!)
        XCTAssertNotNil(stepModel)
        XCTAssertEqual(stepModel.title, "My Title")
        XCTAssertEqual(stepModel.subtitle, "My Subtitle")
        XCTAssertEqual(stepModel.description, "My Description")
        XCTAssertEqual(stepModel.action, .button(title: "Next"))
    }
    
    func test_StepModel_Codable_Init_CheckBox() throws {
        
        let jsonString = """
{
  "title": "My Title",
  "subtitle": "My Subtitle",
  "description": "My Description",
  "action": {
    "checkBox": {
      "title": "Mark as completed"
    }
  }
}
"""
        let stepModel = try JSONDecoder().decode(StepModel.self, from: jsonString.data(using: .utf8)!)
        XCTAssertNotNil(stepModel)
        XCTAssertEqual(stepModel.title, "My Title")
        XCTAssertEqual(stepModel.subtitle, "My Subtitle")
        XCTAssertEqual(stepModel.description, "My Description")
        XCTAssertEqual(stepModel.action, .checkBox(title: "Mark as completed"))
    }
    
    
    func test_StepModel_Codable_Init_Timer() throws {
        
        let jsonString = """
{
  "title": "My Title",
  "subtitle": "My Subtitle",
  "description": "My Description",
  "action": {
    "timer": {
      "seconds": 12
    }
  }
}
"""
        let stepModel = try JSONDecoder().decode(StepModel.self, from: jsonString.data(using: .utf8)!)
        XCTAssertNotNil(stepModel)
        XCTAssertEqual(stepModel.title, "My Title")
        XCTAssertEqual(stepModel.subtitle, "My Subtitle")
        XCTAssertEqual(stepModel.description, "My Description")
        XCTAssertEqual(stepModel.action, .timer(seconds: 12))
    }

}