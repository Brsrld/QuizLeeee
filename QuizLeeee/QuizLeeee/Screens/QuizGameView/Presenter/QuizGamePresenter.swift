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
    var userDefaults: UserDefaultsHelper
    var viewModel: QuizGameViewModelProtocol?
    
    init(interactor: QuizGameInteractorProtocol, 
         view: QuizGameViewProtocol,
         userDefaults: UserDefaultsHelper,
         viewModel: QuizGameViewModelProtocol) {
        
        self.interactor = interactor
        self.view = view
        self.userDefaults = userDefaults
        self.viewModel = viewModel
        self.viewModel?.delegate = self
    }
}

// MARK: - QuizGamePresenter QuizGamePresenter Extension
extension QuizGamePresenter: QuizGamePresenterProtocol {
    
    func fetchQuestions() {
        interactor.fetchQuestion()
    }
    
    func calculateQuestions(tag:Int) {
        view.calculateQuestions(tag: tag)
    }
    
    func handleQuestion(questions: [Question]) {
        viewModel?.question = questions
        view.questionOutput()
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
