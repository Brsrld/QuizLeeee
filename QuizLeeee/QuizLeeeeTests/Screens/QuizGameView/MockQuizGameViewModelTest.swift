//
//  MockQuizGameViewModelTest.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 29.12.2023.
//

import XCTest
@testable import QuizLeeee

final class MockQuizGameViewModelTest: XCTestCase {
    
    var viewModel: QuizGameViewModelProtocol!
    var userDefaults: UserDefaultsHelper!
    var delegate: QuizGameViewModelOutput?
    var questionIndex: Int = 0
    var totalPoint: Int = 0
    var question: [QuizLeeee.Question] = []
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        viewModel = nil
        userDefaults = nil
        delegate = nil
        super.tearDown()
    }
    
    private func prepare() {
        self.questionIndex = 0
        self.totalPoint = 0
    }
}


extension MockQuizGameViewModelTest: QuizGameViewModelProtocol {

    func calculateGameFeatures(tag: Int) { 
        guard let point = question[questionIndex].score else { return }
        var answer = ""
        switch tag {
        case 0:
            answer = "D"
        case 1:
            answer = "A"
        case 2:
            answer = "B"
        case 3:
            answer = "C"
        default:
            fatalError()
        }
        
        if question[questionIndex].correctAnswer == answer {
            totalPoint = (totalPoint) + point
        }
        
        if questionIndex != question.count - 1 {
            questionIndex += 1
            delegate?.updateQuestions()
        } else {
            delegate?.gameOver()
        }
    }
    
    func saveScore() {
        guard let highScore = userDefaults.getData(type: Int.self,
                                                         forKey: .score) else { return }
        if highScore < totalPoint {
            userDefaults.setData(value: totalPoint,
                                       key: .score)
        }
    }
}
