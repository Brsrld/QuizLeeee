//
//  StartQuizGameViewModel.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import Foundation

protocol StartQuizGameViewModelProtocol {
    var highScore: Int { get }
}

final class StartQuizGameViewModel {
    var userHighScore: Int
    
    init(userHighScore: Int) {
        self.userHighScore = userHighScore
    }
}

extension StartQuizGameViewModel:StartQuizGameViewModelProtocol {
    var highScore: Int {
        userHighScore
    }
}
