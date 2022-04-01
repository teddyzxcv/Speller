//
//  StringCheckerTests.swift
//  SpellerTests
//
//  Created by ZhengWu Pan on 01.04.2022.
//

import XCTest
@testable import Speller
import Foundation

class StringCheckerTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() throws {
        let expectation = XCTestExpectation(description: "Chops the vegetables")
        let stringChecker = StringChecker()
        stringChecker.loadChecks(text: "Мня", completion: { results in
            print("asdf")
            for result in results {
                for s in result.s {
                    print(s)
                }
            }
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 1)
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
