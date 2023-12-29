//
//  QuizGameViewModel.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

// MARK: - QuizGameViewModelProtocol
protocol QuizGameViewModelProtocol {
    var question: [Question] { get set }
    var questionIndex: Int { get set }
    var totalPoint: Int { get }
    func saveScore()
    func calculateGameFeatures(tag:Int)
    var delegate: QuizGameViewModelOutput? { get set}
}

// MARK: - QuizGameViewModelOutput
protocol QuizGameViewModelOutput: AnyObject {
    func updateQuestions()
    func gameOver()
}

// MARK: - QuizGameViewModel
final class QuizGameViewModel {
    var question: [Question] = []
    private var questions:[Question] = []
    var questionIndex: Int = 0
    var totalPoint: Int = 0
    weak var delegate: QuizGameViewModelOutput?
    var userDefaults: UserDefaultsHelper
    
    init(userDefaults: UserDefaultsHelper) {
        self.userDefaults = userDefaults
    }
}

// MARK: - QuizGameViewModel QuizGameViewModelProtocol Extension
extension QuizGameViewModel: QuizGameViewModelProtocol {
    func saveScore() {
        guard let highScore = userDefaults.getData(type: Int.self,
                                                         forKey: .score) else { return }
        if highScore < totalPoint {
            userDefaults.setData(value: totalPoint,
                                       key: .score)
        }
    }
    
    func calculateGameFeatures(tag:Int) {
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
            totalPoint = totalPoint + point
        }
        
        if questionIndex != question.count - 1 {
            questionIndex += 1
            delegate?.updateQuestions()
        } else {
            delegate?.gameOver()
        }
    }
}
