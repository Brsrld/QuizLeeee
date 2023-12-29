//
//  MockQuizGameInteractorTest.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 29.12.2023.
//

import XCTest
@testable import QuizLeeee

final class MockQuizGameInteractorTest: XCTestCase {
    
    var interactor: QuizGameInteractorProtocol?
    var presenter: QuizGamePresenterProtocol?
    var userDafaults: UserDefaultsHelper?
    var service: QuizServiceable?
    
    let fetchQuistionsExpectation = XCTestExpectation(description: "Quistions Expectation")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        presenter = nil
        interactor = nil
        userDafaults = nil
        super.tearDown()
    }
    
    private func prepare(isError:Bool = false) {
        let presenter = MockQuizGamePresenterTest()
        let interactor = QuizGameInteractor(httpClient: isError ? HttpClient(urlSession: nil)
                                            : HttpClient())
        let view = MockQuizGameViewTest()
        let userDefaults = UserDefaultsHelper()
        
        self.interactor = interactor
        self.presenter = presenter
        self.userDafaults = userDefaults
        
        presenter.interactor = self
        presenter.view = view
        interactor.presenter = presenter
        
    }
    
    func test_fetch_question() {
        prepare()
        self.presenter?.fetchQuestions()
        wait(for: [fetchQuistionsExpectation], timeout: 2)
   }
}

extension MockQuizGameInteractorTest: QuizGameInteractorProtocol {
    func fetchQuestion() {
        self.presenter?.loading()
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service?.fetchQuestions()
            self.presenter?.finished()
            switch result {
            case .success(let success):
                guard let questions = success.questions else { return }
                self.presenter?.handleQuestion(questions: questions)
            case .failure(let failure):
                self.presenter?.handleError(error: failure.customMessage)
            case .none:
                fatalError()
            }
        }
        fetchQuistionsExpectation.fulfill()
    }
}
