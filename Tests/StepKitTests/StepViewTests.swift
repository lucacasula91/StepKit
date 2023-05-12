import XCTest
@testable import StepKit

final class StepViewTests: XCTestCase {
    
    func test_StepView_Initialization() throws {
       
        let model = Step(title: "Step 1",
                              subtitle: "Add all powder ingredients",
                              description: "In a bowl put the flour, the salt and the yeast.\nYou can use dry or instant yeast.")
        let stepView = StepView(model: model)
        
        XCTAssertEqual(stepView.model.title, "Step 1")
        XCTAssertEqual(stepView.model.subtitle, "Add all powder ingredients")
        XCTAssertEqual(stepView.model.description, "In a bowl put the flour, the salt and the yeast.\nYou can use dry or instant yeast.")
    }
}
