//
//  MockStartQuizViewModelTest.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 29.12.2023.
//

import XCTest
@testable import QuizLeeee

final class MockStartQuizViewModelTest: XCTestCase {
    
    private var viewModel: StartQuizGameViewModel!
    
    let fetchHighScoreExpectation = XCTestExpectation(description: "Fetch High Score")
    
    override func setUp() {
        super.setUp()
        viewModel = StartQuizGameViewModel(userHighScore: 10)
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
}


extension MockStartQuizViewModelTest: StartQuizGameViewModelProtocol {
    var highScore: Int {
        print("ele")
        return 5
    }
}
