//
//  MockStartQuizView.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import XCTest
@testable import QuizLeeee

final class MockStartQuizView: XCTestCase {
    
    private var presenter: StartQuizViewPresenter!
    
    let fetchHighScoreExpectation = XCTestExpectation(description: "Fetch High Score")
    
    override func setUp() {
        super.setUp()
        let interactor = StartQuizViewInteractor()
        presenter = StartQuizViewPresenter(interactor: interactor,
                                           view: self)
        interactor.presenter = presenter
    }

    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func test_fetch_high_score() {
        presenter.fetchHighScore()
        wait(for: [fetchHighScoreExpectation], timeout: 2)
   }
}


extension MockStartQuizView: StartQuizViewProtocol {
    func handleHighScore(_ output: QuizLeeee.StartQuizGameViewModelProtocol) {
        XCTAssertEqual(output.highScore, 950)
        fetchHighScoreExpectation.fulfill()
    }
}
