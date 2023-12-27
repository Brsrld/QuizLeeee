//
//  QuizGameBuilder.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

final class QuizGameBuilder {
    static func build() -> QuizGameViewController {
        let httpClient = HttpClient()
        let interactor = QuizGameInteractor(httpClient: httpClient)
        let viewController = QuizGameViewController()
        let presenter = QuizGamePresenter(interactor: interactor,
                                          view: viewController)
        
        interactor.presenter = presenter
        viewController.presenter = presenter
     
        return viewController
    }
}
