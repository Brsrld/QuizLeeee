//
//  StartQuizViewBuilder.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation
import UIKit

// MARK: - StartQuizViewBuilder
final class StartQuizViewBuilder {
    static func build(coordinator: Coordinator) -> StartQuizViewController {
        let viewController = StartQuizViewController()
        let interactor = StartQuizViewInteractor()
        let router = StartQuizViewRouter(coordinator: coordinator)
        let presenter = StartQuizViewPresenter(interactor: interactor,
                                               view: viewController)
        
        viewController.router = router
        viewController.presenter = presenter
        interactor.presenter = presenter
        
        return viewController
    }
}
