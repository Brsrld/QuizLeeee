//
//  MockStartQuizInteractorTest.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 29.12.2023.
//

import XCTest
@testable import QuizLeeee

final class MockStartQuizInteractorTest: XCTestCase {
    
    var interactor: StartQuizViewInteractorProtocol?
    var presenter: StartQuizViewPresenterProtocol?
    var userDafaults: UserDefaultsHelper?
    
    let fetchHighScoreExpectation = XCTestExpectation(description: "Fetch High Score")
    
    override func setUp() {
        super.setUp()
    }
    
    private func prepare() {
        let presenter = MockStartQuizPresenterTest()
        let interactor = StartQuizViewInteractor()
        let view = MockStartQuizViewTest()
        let userDefaults = UserDefaultsHelper()
        
        self.interactor = interactor
        self.presenter = presenter
        self.userDafaults = userDefaults
        
        presenter.interactor = self
        presenter.view = view
        interactor.presenter = presenter
        
    }

    override func tearDown() {
        interactor = nil
        presenter = nil
        super.tearDown()
    }
    
    func test_fetch_high_score() {
        prepare()
        presenter?.fetchHighScore()
        wait(for: [fetchHighScoreExpectation], timeout: 2)
   }
}


extension MockStartQuizInteractorTest: StartQuizViewInteractorProtocol {

    func fetchQuestion() {
        let score = userDafaults?.getData(type: Int.self, forKey: .score)
        XCTAssertNotNil(score)
        presenter?.handleHighScore(score: score ?? 0)
        fetchHighScoreExpectation.fulfill()
    }
}
