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
        let stepModel = try JSONDecoder().decode(Step.self, from: jsonString.data(using: .utf8)!)
        XCTAssertNotNil(stepModel)
        XCTAssertEqual(stepModel.title, "My Title")
        XCTAssertEqual(stepModel.subtitle, "My Subtitle")
        XCTAssertEqual(stepModel.description, "My Description")
        XCTAssertEqual(stepModel.action, .button(title: "Next", completed: false))
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
        let stepModel = try JSONDecoder().decode(Step.self, from: jsonString.data(using: .utf8)!)
        XCTAssertNotNil(stepModel)
        XCTAssertEqual(stepModel.title, "My Title")
        XCTAssertEqual(stepModel.subtitle, "My Subtitle")
        XCTAssertEqual(stepModel.description, "My Description")
        XCTAssertEqual(stepModel.action, .checkBox(title: "Mark as completed"))
    }
    
    func test_StepModel_Codable_Init_CheckBoxGroup() throws {
        
        let jsonString = """
{
  "title": "My Title",
  "subtitle": "My Subtitle",
  "description": "My Description",
  "action": {
    "checkBoxGroup": {
      "items": ["First item", "Second item"]
    }
  }
}
"""
        let stepModel = try JSONDecoder().decode(Step.self, from: jsonString.data(using: .utf8)!)
        XCTAssertNotNil(stepModel)
        XCTAssertEqual(stepModel.title, "My Title")
        XCTAssertEqual(stepModel.subtitle, "My Subtitle")
        XCTAssertEqual(stepModel.description, "My Description")
        XCTAssertEqual(stepModel.action, .checkBoxGroup(items: ["First item", "Second item"]))
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
        let stepModel = try JSONDecoder().decode(Step.self, from: jsonString.data(using: .utf8)!)
        XCTAssertNotNil(stepModel)
        XCTAssertEqual(stepModel.title, "My Title")
        XCTAssertEqual(stepModel.subtitle, "My Subtitle")
        XCTAssertEqual(stepModel.description, "My Description")
        XCTAssertEqual(stepModel.action, .timer(seconds: 12))
    }
    
    func test_StepModel_Codable_Init_Timer_And_Notification() throws {
        
        let jsonString = """
{
  "title": "My Title",
  "subtitle": "My Subtitle",
  "description": "My Description",
  "action": {
    "timer": {
      "seconds": 12,
      "notification": {
        "title": "Step 1 completed",
        "subtitle": "Let's jump to the next step"
      }
    }
  }
}
"""
        
        let stepModel = try JSONDecoder().decode(Step.self, from: jsonString.data(using: .utf8)!)
        XCTAssertNotNil(stepModel)
        XCTAssertEqual(stepModel.title, "My Title")
        XCTAssertEqual(stepModel.subtitle, "My Subtitle")
        XCTAssertEqual(stepModel.description, "My Description")
        XCTAssertEqual(stepModel.action, .timer(seconds: 12,
                                                notification: TimerNotification(title: "Step 1 completed",
                                                                                subtitle: "Let's jump to the next step")))
    }

}
