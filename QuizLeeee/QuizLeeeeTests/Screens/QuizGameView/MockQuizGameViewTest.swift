//
//  MockQuizGameViewTest.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 29.12.2023.
//

import XCTest
@testable import QuizLeeee

final class MockQuizGameViewTest: XCTestCase {
    
    var presenter: MockQuizGamePresenterTest?
    var viewModel: QuizGameViewModelProtocol?
    
    let fetchQuistionsExpectation = XCTestExpectation(description: "Quistions Expectation")
    let loadingExpectation = XCTestExpectation(description: "Loading Expectation")
    let finishedExpectation = XCTestExpectation(description: "Finished Expectation")
    let handleQuestionsExpectation = XCTestExpectation(description: "Handle Questions Expectation")
    let handleErrorExpectation = XCTestExpectation(description: "Handle Error Expectation")
    let calculateQuestionsExpectation = XCTestExpectation(description: "Calculate Questions Expectation")
    let updateUIExpectation = XCTestExpectation(description: "Update UI Expectation")
    let gameOverExpectation = XCTestExpectation(description: "Game Over Expectation")
    
    override func setUp() {
        super.setUp()
        self.presenter = nil
        self.viewModel = nil
    }
    
    private func prepare(isError:Bool = false) {
        let presenter = MockQuizGamePresenterTest()
        let interactor = MockQuizGameInteractorTest()
        let userDafaults = UserDefaultsHelper()
        let viewModel = MockQuizGameViewModelTest()
        
        interactor.presenter = presenter
        interactor.userDafaults = userDafaults
        interactor.service = QuizService(service: isError ? HttpClient(urlSession: nil) : HttpClient())
        presenter.interactor = interactor
        presenter.view = self
        viewModel.delegate = presenter
        
        self.presenter = presenter
        self.viewModel = viewModel
    }
    
    func test_fetch_question() {
        prepare()
        presenter?.fetchQuestions()
        wait(for: [fetchQuistionsExpectation], timeout: 2)
   }
    
    func test_loading() {
        prepare()
        presenter?.fetchQuestions()
        wait(for: [loadingExpectation], timeout: 2)
   }
    
    func test_finished() {
        prepare()
        presenter?.fetchQuestions()
        wait(for: [finishedExpectation], timeout: 2)
   }
    
    func test_handleError() {
        prepare(isError: true)
        presenter?.fetchQuestions()
        wait(for: [handleErrorExpectation ], timeout: 2)
   }
    
    func test_gameOver() {
        prepare()
        presenter?.isDelegate = true
        presenter?.fetchQuestions()
        viewModel?.questionIndex = 7
        wait(for: [gameOverExpectation], timeout: 2)
   }
    
    func test_UpdateQuestions() {
        prepare()
        presenter?.isDelegate = true
        presenter?.fetchQuestions()
        wait(for: [updateUIExpectation], timeout: 2)
   }
}

extension MockQuizGameViewTest: QuizGameViewProtocol {
    func questionOutput() {
        fetchQuistionsExpectation.fulfill()
    }
    
    func calculateQuestions(tag: Int) { 
        viewModel?.calculateGameFeatures(tag: tag)
        XCTAssertNotNil(tag)
        calculateQuestionsExpectation.fulfill()
    }
    
    func errorOutput(_ output: String) {
        XCTAssertNotNil(output)
        handleErrorExpectation.fulfill()
    }
    
    func loading() {
        loadingExpectation.fulfill()
    }
    
    func finished() {
        finishedExpectation.fulfill()
    }
    
    func updateUI() {
        updateUIExpectation.fulfill()
    }
    
    func gameOver() {
        gameOverExpectation.fulfill()
    }
}
