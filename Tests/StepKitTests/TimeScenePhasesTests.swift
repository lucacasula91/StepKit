//
//  TimeScenePhasesTests.swift
//  StepKitTests
//
//  Created by Luca Casula on 06/05/23.
//

import XCTest

@testable import StepKit
final class TimeScenePhasesTests: XCTestCase {

    func testExample() throws {
        let backgroundDate = Date().addingTimeInterval(-15)
        let activeDate = Date()
        
        TimerScenePhases.backgroundDate = backgroundDate
        let secondsOfInactivity = TimerScenePhases.getInactivitySecondsTill(activeDate: activeDate)
        XCTAssertEqual(secondsOfInactivity, 15)
        
    }

}
