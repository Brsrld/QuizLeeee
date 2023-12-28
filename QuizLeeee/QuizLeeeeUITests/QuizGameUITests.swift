//
//  QuizGameUITests.swift
//  QuizLeeeeUITests
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import XCTest

final class QuizGameUITests: XCTestCase {

    private var app: XCUIApplication!
    
    override func setUp() {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments = ["-ui-testing"]
        app.launchEnvironment = ["-networking-success":"1"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
    }
    
    func testNavigation() throws {
        let detail = app.otherElements.buttons["startButton"].firstMatch
        detail.tap()
    }
    
    func testGameAllPointsLabel() throws {
        try testNavigation()
        let label = app.staticTexts.element(matching: .any, identifier: "gameAllPointsLabel").label
        XCTAssertNotNil(label)
    }
    
    func testGameSinglePointLabel() throws {
        try testNavigation()
        let label = app.staticTexts.element(matching: .any, identifier: "gameSinglePointLabel").label
        XCTAssertNotNil(label)
    }
    
    func testGameQuestionLabel() throws {
        try testNavigation()
        let label = app.staticTexts.element(matching: .any, identifier: "gameQuestionLabel").label
        XCTAssertNotNil(label)
    }
    
    func testGameImageView() throws {
        try testNavigation()
        let image = app.images["gameImageView"].firstMatch
        XCTAssert(image.exists)
    }
    
    func testaButton() throws {
        try testNavigation()
        let aButton = app.otherElements.buttons["gameAButton"].firstMatch
        aButton.tap()
    }
    
    func testbButton() throws {
        try testNavigation()
        let bButton = app.otherElements.buttons["gameBButton"].firstMatch
        bButton.tap()
    }
    
    func testcButton() throws {
        try testNavigation()
        let cButton = app.otherElements.buttons["gameCButton"].firstMatch
        cButton.tap()
    }
    
    func testdButton() throws {
        try testNavigation()
        let dButton = app.otherElements.buttons["gameDButton"].firstMatch
        dButton.tap()
    }
}
