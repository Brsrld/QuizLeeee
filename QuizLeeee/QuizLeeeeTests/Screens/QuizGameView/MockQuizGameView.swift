//
//  MockQuizGameView.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import XCTest
@testable import QuizLeeee

final class MockQuizGameView: XCTestCase {
    private var presenter: QuizGamePresenter!
    private var interactor: QuizGameInteractor!
    
    let fetchQuistionsExpectation = XCTestExpectation(description: "Quistions Expectation")
    let loadingExpectation = XCTestExpectation(description: "Loading Expectation")
    let finishedExpectation = XCTestExpectation(description: "Finished Expectation")
    let calculateQuestionsExpectation = XCTestExpectation(description: "Calculate Questions Expectation")
    let gameOverExpectation = XCTestExpectation(description: "Game Over Expectation")
    let failExpectation = XCTestExpectation(description: "Fail Expectation")
    
    private var isGameOver = false
    
    override func setUp() {
        super.setUp()
        interactor = QuizGameInteractor(httpClient: HttpClient())
        presenter = QuizGamePresenter(interactor: interactor,
                                           view: self)
        interactor.presenter = presenter
    }
    
    private func reSetup() {
        interactor = QuizGameInteractor(httpClient: HttpClient(urlSession: nil))
        presenter = QuizGamePresenter(interactor: interactor,
                                           view: self)
        interactor.presenter = presenter
    }

    override func tearDown() {
        presenter = nil
        super.tearDown()
    }
    
    func test_fetch_high_score() {
        presenter.fetchQuestions()
        wait(for: [fetchQuistionsExpectation], timeout: 2)
   }
    
    func test_loading() {
        presenter.fetchQuestions()
        wait(for: [loadingExpectation], timeout: 2)
   }
    
    func test_finished() {
        presenter.fetchQuestions()
        wait(for: [finishedExpectation], timeout: 2)
   }
    
    func test_calculateQuestions() {
        presenter.fetchQuestions()
        wait(for: [calculateQuestionsExpectation], timeout: 2)
    }
    
    func test_gameOver() {
        presenter.fetchQuestions()
        isGameOver.toggle()
        wait(for: [gameOverExpectation], timeout: 2)
    }
    
    func test_fail() {
        reSetup()
        presenter.fetchQuestions()
        wait(for: [failExpectation], timeout: 2)
    }
}

extension MockQuizGameView: QuizGameViewProtocol {
    func questionOutput(_ output: QuizLeeee.QuizGameViewModel) {
        XCTAssertNotNil(output.question)
        fetchQuistionsExpectation.fulfill()
        presenter.calculateQuestions(tag: 1)
    }
    
    func errorOutput(_ output: String) {
        XCTAssertNotNil(output)
        failExpectation.fulfill()
    }
    
    func loading() {
        loadingExpectation.fulfill()
    }
    
    func finished() {
        finishedExpectation.fulfill()
    }
    
    func calculateQuestions(tag: Int, _ output: QuizLeeee.QuizGameViewModel) {
        output.questionIndex = isGameOver ? 7 : 0
        output.calculateGameFeatures(tag: tag)
    }
    
    func updateUI() {
        calculateQuestionsExpectation.fulfill()
    }
    
    func gameOver() {
        gameOverExpectation.fulfill()
    }
}
