//
//  QuizGameRouter.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import Foundation

// MARK: - QuizGameRouterProtocol
protocol QuizGameRouterProtocol {
    func pop()
    var coordinator: Coordinator { get }
}

// MARK: - QuizGameRouter
final class QuizGameRouter: QuizGameRouterProtocol {
    
    var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func pop() {
        coordinator.navigationController?.popViewController(animated: true)
    }
}
