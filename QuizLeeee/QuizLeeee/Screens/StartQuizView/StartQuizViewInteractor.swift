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
    var userDafaults: UserDefaultsHelper? { get }
    func fetchQuestion()
}

// MARK: - StartQuizViewInteractor
final class StartQuizViewInteractor {
    var presenter: StartQuizViewPresenterProtocol?
    var userDafaults: UserDefaultsHelper?
}

// MARK: - StartQuizViewInteractor StartQuizViewInteractorProtocol Extension
extension StartQuizViewInteractor: StartQuizViewInteractorProtocol {
    
    func fetchQuestion() {
        guard let score = userDafaults?.getData(type: Int.self,forKey: .score) else { return }
        presenter?.handleHighScore(score: score)
    }
}
