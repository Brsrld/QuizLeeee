//
//  QuizGameInteractor.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

// MARK: - QuizGameInteractorProtocol
protocol QuizGameInteractorProtocol {
    var presenter: QuizGamePresenterProtocol? { get set }
    func fetchQuestion()
}

// MARK: - QuizGameInteractor
final class QuizGameInteractor {
    
    var presenter: QuizGamePresenterProtocol?
    private let service: QuizServiceable
    
    init(httpClient: HTTPClientProtocol) {
        self.service = QuizService(service: httpClient)
    }
}

// MARK: - QuizGameInteractor QuizGameInteractorProtocol Extension
extension QuizGameInteractor: QuizGameInteractorProtocol {
    
    func fetchQuestion() {
        self.presenter?.loading()
        Task { [weak self] in
            guard let self = self else { return }
            let result = await self.service.fetchQuestions()
            self.presenter?.finished()
            switch result {
            case .success(let success):
                guard let questions = success.questions else { return }
                self.presenter?.handleQuestion(questions: questions)
            case .failure(let failure):
                self.presenter?.handleError(error: failure.customMessage)
            }
        }
    }
}

