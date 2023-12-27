//
//  QuizGameViewModel.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

protocol QuizGameViewModelProtocol {
    var question: [Question] { get }
    var questionIndex: Int { get }
    var totalPoint: Int { get }
}

protocol QuizGameViewModelOutput: AnyObject {
    func updateQuestions()
    func gameOver()
}

final class QuizGameViewModel {
    private var questions:[Question] = []
    var questionIndex: Int = 0
    var totalPoint: Int = 0
    weak var delegate: QuizGameViewModelOutput?
    
    init(questions: [Question], 
         delegate: QuizGameViewModelOutput?) {
        self.questions = questions
        self.delegate = delegate
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

extension QuizGameViewModel: QuizGameViewModelProtocol {

    var question: [Question] {
        questions
    }
}
