//
//  StartQuizViewPresenter.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import Foundation

// MARK: - StartQuizViewPresenterProtocol
protocol StartQuizViewPresenterProtocol {
    func fetchHighScore()
    func handleHighScore(score:Int)
}

// MARK: - StartQuizViewPresenter
final class StartQuizViewPresenter {
    let interactor: StartQuizViewInteractorProtocol
    let view: StartQuizViewProtocol
    
    init(interactor: StartQuizViewInteractorProtocol,
         view: StartQuizViewProtocol) {
        self.interactor = interactor
        self.view = view
    }
}

// MARK: - StartQuizViewPresenter StartQuizViewPresenterProtocol Extension
extension StartQuizViewPresenter: StartQuizViewPresenterProtocol {
    func handleHighScore(score: Int) {
        let viewModel = StartQuizGameViewModel(userHighScore: score)
        view.handleHighScore(viewModel)
    }
    
    func fetchHighScore() {
        interactor.fetchQuestion()
    }
}
