//
//  QuizGamePresenter.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

// MARK: - QuizGamePresenterProtocol
protocol QuizGamePresenterProtocol {
    func handleError(error: String)
    func handleQuestion(questions: [Question])
    func loading()
    func finished()
    func calculateQuestions(tag:Int)
    func fetchQuestions()
}

// MARK: - QuizGamePresenter
final class QuizGamePresenter {
    
    let interactor: QuizGameInteractorProtocol
    let view: QuizGameViewProtocol
    var viewModel:QuizGameViewModel?
    
    init(interactor: QuizGameInteractorProtocol, 
         view: QuizGameViewProtocol) {
        self.interactor = interactor
        self.view = view
    }
}

// MARK: - QuizGamePresenter QuizGamePresenter Extension
extension QuizGamePresenter: QuizGamePresenterProtocol {
    
    func fetchQuestions() {
        interactor.fetchQuestion()
    }
    
    
    func calculateQuestions(tag:Int) {
        guard let viewModel = self.viewModel else { return }
        view.calculateQuestions(tag: tag, viewModel)
    }
    
    func handleQuestion(questions: [Question]) {
        let viewModel = QuizGameViewModel(questions: questions, delegate: self)
        self.viewModel = viewModel
        view.questionOutput(viewModel)
    }
    
    func loading() {
        view.loading()
    }
    
    func finished() {
        view.finished()
    }
    
    func handleError(error: String) {
        view.errorOutput(error)
    }
}

// MARK: - QuizGamePresenter QuizGameViewModelOutput Extension
extension QuizGamePresenter: QuizGameViewModelOutput {
    
    func gameOver() {
        view.gameOver()
    }
    
    func updateQuestions() {
        view.updateUI()
    }
}
