//
//  StartQuizGameViewModel.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import Foundation

// MARK: - StartQuizGameViewModelProtocol
protocol StartQuizGameViewModelProtocol {
    var highScore: Int { get }
}

// MARK: - StartQuizGameViewModel
final class StartQuizGameViewModel {
    var userHighScore: Int
    
    init(userHighScore: Int) {
        self.userHighScore = userHighScore
    }
}

// MARK: - StartQuizGameViewModel StartQuizGameViewModelProtocol Extension
extension StartQuizGameViewModel: StartQuizGameViewModelProtocol {
    var highScore: Int {
        userHighScore
    }
}
