//
//  MockStartQuizViewTest.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 29.12.2023.
//
import XCTest
@testable import QuizLeeee

final class MockStartQuizViewTest: XCTestCase {
    
    private var view: StartQuizViewProtocol!
    var presenter: MockStartQuizPresenterTest?
    
    let handleHighScoreExpectation = XCTestExpectation(description: "Handle High Score Expectation")
    
    override func setUp() {
        super.setUp()
    }
    
    private func prepare() {
        let view = StartQuizViewController()
        let presenter = MockStartQuizPresenterTest()
        let interactor = MockStartQuizInteractorTest()
        let userDafaults = UserDefaultsHelper()
        
        interactor.presenter = presenter
        interactor.userDafaults = userDafaults
        presenter.interactor = interactor
        presenter.view = self
        view.presenter = presenter
        self.presenter = presenter
        self.view = view
    }

    override func tearDown() {
        view = nil
        presenter = nil
        super.tearDown()
    }
    
    func test_fetch_high_score() {
        prepare()
        presenter?.fetchHighScore()
        wait(for: [handleHighScoreExpectation], timeout: 2)
   }
}


extension MockStartQuizViewTest: StartQuizViewProtocol {
    func handleHighScore(_ output: QuizLeeee.StartQuizGameViewModelProtocol) {
        XCTAssertNotNil(output.highScore)
        handleHighScoreExpectation.fulfill()
    }
}
