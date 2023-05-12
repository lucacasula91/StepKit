//
//  TestClassTest.swift
//  StepKitTests
//
//  Created by Luca Casula on 09/05/23.
//

import XCTest

final class TestClassTest: XCTestCase {

    func testExample() throws {
        XCTAssertEqual(["Timothy", "Matthew", "Kevin"], SortAndFilterExercise().sortAndFilter(["Alan", "Timothy", "Kevin", "Ethan", "Matthew"]))
        XCTAssertEqual(["Toothless", "tiger", "skunk", "raccoon", "lion", "Big Bird", "bear", "baboon"], SortAndFilterExercise().sortAndFilter(["lion", "tiger", "bear", "eagle", "Big Bird", "raccoon", "skunk", "Toothless", "aardvark", "baboon", "Old Yeller"]))
    }


}


import Foundation
class SortAndFilterExercise {
    func sortAndFilter(_ stringArray: [String]) -> [String] {
        var output = [String]()
       
        let temp = stringArray.sorted{ $0.localizedCompare($1) == .orderedDescending}

        for item in temp {
            if let firstChar = item.first?.lowercased(), ["a", "e", "i", "o", "u"].contains(firstChar) {
                continue
            } else {
                output.append(item)
            }
        }
        
       
        
       
        return output
    }
}
