//
//  StartQuizViewInteractor.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import Foundation

// MARK: - StartQuizViewInteractorProtocol
protocol StartQuizViewInteractorProtocol {
    var presenter: StartQuizViewPresenterProtocol? { get set }
    func fetchQuestion()
}

// MARK: - StartQuizViewInteractor
final class StartQuizViewInteractor {
    
    var presenter: StartQuizViewPresenterProtocol?
  
}

// MARK: - StartQuizViewInteractor StartQuizViewInteractorProtocol Extension
extension StartQuizViewInteractor: StartQuizViewInteractorProtocol {
    
    func fetchQuestion() {
        guard let score = UserDefaultsHelper.getData(type: Int.self,
                                                     forKey: .score) else { return }
        presenter?.handleHighScore(score: score)
    }
}
