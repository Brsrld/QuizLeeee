//
//  StartQuizUITests.swift
//  QuizLeeeeUITests
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import XCTest

final class StartQuizUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testStartImage() throws {
        let image = app.images["StartImage"].firstMatch
        XCTAssert(image.exists)
    }
    
    func testLabel() throws {
        let label = app.staticTexts.element(matching: .any, identifier:"startLabel").label
        XCTAssertNotNil(label)
    }
    
    func testNavigation() throws {
        let detail = app.otherElements.buttons["startButton"].firstMatch
        detail.tap()
    }
}

