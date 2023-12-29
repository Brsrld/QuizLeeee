//
//  MockQuizGameInteractorTest.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 29.12.2023.
//

import XCTest
@testable import QuizLeeee

final class MockQuizGameInteractorTest: XCTestCase {
    
    var presenter: QuizGamePresenterProtocol?
    var userDafaults: UserDefaultsHelper?
    var service: QuizServiceable?
    
    let fetchQuistionsExpectation = XCTestExpectation(description: "Quistions Expectation")
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        presenter = nil
        userDafaults = nil
        super.tearDown()
    }
    
    private func prepare(isError:Bool = false) {
        let servicePro = isError ? HttpClient(urlSession: nil)
        : HttpClient()
        let service = QuizService(service: servicePro)
        let presenter = MockQuizGamePresenterTest()
        let view = MockQuizGameViewTest()
        let userDefaults = UserDefaultsHelper()
        
        self.presenter = presenter
        self.userDafaults = userDefaults
        self.service = service
        
        presenter.interactor = self
        presenter.view = view
        
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
