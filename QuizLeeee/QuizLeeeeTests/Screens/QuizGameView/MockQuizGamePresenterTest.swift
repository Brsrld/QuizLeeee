//
//  MockQuizGamePresenterTest.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 29.12.2023.
//

import XCTest
@testable import QuizLeeee

final class MockQuizGamePresenterTest: XCTestCase {
    
    var view: MockQuizGameViewTest?
    var interactor: QuizGameInteractorProtocol?
    var viewModel: MockQuizGameViewModelTest?
    var userDefaults: UserDefaultsHelper?
    var isDelegate = false
    
    let fetchQuistionsExpectation = XCTestExpectation(description: "Quistions Expectation")
    let loadingExpectation = XCTestExpectation(description: "Loading Expectation")
    let finishedExpectation = XCTestExpectation(description: "Finished Expectation")
    let handleQuestionsExpectation = XCTestExpectation(description: "Handle Questions Expectation")
    let handleErrorExpectation = XCTestExpectation(description: "Handle Error Expectation")
    let calculateQuestionsExpectation = XCTestExpectation(description: "Calculate Questions Expectation")
    let updateQuestionsExpectation = XCTestExpectation(description: "Update Questions Expectation")
    let gameOverExpectation = XCTestExpectation(description: "Game Over Expectation")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        view = nil
        interactor = nil
        viewModel = nil
        userDefaults = nil
        super.tearDown()
    }
    
    private func prepare(isError: Bool = false) {
        let userDafaults = UserDefaultsHelper()
        let view = MockQuizGameViewTest()
        let interactor = MockQuizGameInteractorTest()
        let viewModel = MockQuizGameViewModelTest()
        viewModel.userDefaults = userDafaults
        viewModel.delegate = self
       
        view.viewModel = viewModel
        view.presenter = self
        
        interactor.presenter = self
        interactor.userDafaults = userDafaults
        interactor.service = QuizService(service: isError ? HttpClient(urlSession: nil) 
                                         : HttpClient())
        
        self.interactor = interactor
        self.view = view
        self.userDefaults = userDafaults
    }
    
    func test_fetch_question() {
        prepare()
        view?.presenter?.fetchQuestions()
        wait(for: [fetchQuistionsExpectation], timeout: 2)
   }
    
    func test_loading() {
        prepare()
        view?.presenter?.fetchQuestions()
        wait(for: [loadingExpectation], timeout: 2)
   }
    
    func test_finished() {
        prepare()
        view?.presenter?.fetchQuestions()
        wait(for: [finishedExpectation], timeout: 2)
   }
    
    func test_handleError() {
        prepare(isError: true)
        view?.presenter?.fetchQuestions()
        wait(for: [handleErrorExpectation ], timeout: 2)
   }
    
    func test_handleQuestions() {
        prepare()
        view?.presenter?.fetchQuestions()
        wait(for: [handleQuestionsExpectation ], timeout: 2)
   }
    
    func test_calculateQuestions() {
        prepare()
        self.isDelegate = true
        view?.presenter?.fetchQuestions()
        wait(for: [calculateQuestionsExpectation], timeout: 2)
   }
    
    func test_gameOver() {
        prepare()
        self.isDelegate = true
        view?.presenter?.fetchQuestions()
        view?.viewModel?.questionIndex = 7
        wait(for: [gameOverExpectation], timeout: 2)
   }
    
    func test_UpdateQuestions() {
        prepare()
        self.isDelegate = true
        view?.presenter?.fetchQuestions()
        wait(for: [updateQuestionsExpectation], timeout: 2)
   }
}

extension MockQuizGamePresenterTest: QuizGamePresenterProtocol {
    func handleError(error: String) {
        view?.errorOutput(error)
        XCTAssertNotNil(error)
        handleErrorExpectation.fulfill()
    }
    
    func handleQuestion(questions: [QuizLeeee.Question]) {
        view?.viewModel?.question = questions
        if isDelegate {
            view?.presenter?.calculateQuestions(tag: 1)
        }
       
        view?.questionOutput()
        XCTAssertNotNil(questions)
        handleQuestionsExpectation.fulfill()
    }
    
    func loading() {
        view?.loading()
        loadingExpectation.fulfill()
    }
    
    func finished() {
        view?.finished()
        finishedExpectation.fulfill()
    }
    
    func calculateQuestions(tag: Int) {
        view?.calculateQuestions(tag: tag)
        calculateQuestionsExpectation.fulfill()
    }
    
    func fetchQuestions() {
        interactor?.fetchQuestion()
        fetchQuistionsExpectation.fulfill()
    }
}

extension MockQuizGamePresenterTest: QuizGameViewModelOutput {
    func updateQuestions() {
        view?.updateUI()
        updateQuestionsExpectation.fulfill()
    }
    
    func gameOver() {
        view?.gameOver()
        gameOverExpectation.fulfill()
    }
}
    
