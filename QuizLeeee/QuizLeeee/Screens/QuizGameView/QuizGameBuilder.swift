//
//  QuizGameBuilder.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

// MARK: - QuizGameBuilder
final class QuizGameBuilder {
    static func build(coordinator: Coordinator) -> QuizGameViewController {
        let httpClient = HttpClient()
        let interactor = QuizGameInteractor(httpClient: httpClient)
        let viewController = QuizGameViewController()
        let presenter = QuizGamePresenter(interactor: interactor,
                                          view: viewController)
        let router = QuizGameRouter(coordinator: coordinator)
        
        interactor.presenter = presenter
        viewController.router = router
        viewController.presenter = presenter
     
        return viewController
    }
}
