//
//  MockStartQuizPresenterTest.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import XCTest
@testable import QuizLeeee

final class MockStartQuizPresenterTest: XCTestCase {
    
    private var presenter: StartQuizViewPresenterProtocol!
    var view: MockStartQuizViewTest!
    var interactor: MockStartQuizInteractorTest!
    var viewModel: MockStartQuizViewModelTest?
    
    let fetchHighScoreExpectation = XCTestExpectation(description: "Fetch High Score")
    let handleScoreExpectation = XCTestExpectation(description: "Handle Score Expectation")
    
    override func setUp() {
        super.setUp()
       
    }
    
    private func prepare() {
        let view = MockStartQuizViewTest()
        let interactor = MockStartQuizInteractorTest()
        let presenter = StartQuizViewPresenter(interactor: interactor,
                                               view: view)
        
        interactor.presenter = self
        interactor.interactor = interactor
        interactor.userDafaults = UserDefaultsHelper()
        view.presenter = self
        
        self.interactor = interactor
        self.view = view
        self.presenter = presenter
    }

    override func tearDown() {
        presenter = nil
        view = nil
        interactor = nil
        viewModel = nil
        super.tearDown()
    }
    
    func test_handleHighScore() {
        prepare()
        presenter.fetchHighScore()
        wait(for: [fetchHighScoreExpectation], timeout: 2)
    }
    
    func test_fetchHighScore() {
        prepare()
        view.presenter?.fetchHighScore()
        wait(for: [handleScoreExpectation], timeout: 2)
    }
}


extension MockStartQuizPresenterTest: StartQuizViewPresenterProtocol {
    func fetchHighScore() {
        interactor.fetchQuestion()
        handleScoreExpectation.fulfill()
    }
    
    func handleHighScore(score: Int) {
        let viewModel = StartQuizGameViewModel(userHighScore: score)
        view.handleHighScore(viewModel)
        XCTAssertNotNil(viewModel.userHighScore)
        fetchHighScoreExpectation.fulfill()
    }
}
