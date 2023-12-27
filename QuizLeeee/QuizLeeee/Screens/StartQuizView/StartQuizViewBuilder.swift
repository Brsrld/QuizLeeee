//
//  StartQuizViewBuilder.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

final class StartQuizViewBuilder {
    static func build() -> StartQuizViewController {
        let viewController = StartQuizViewController()
        viewController.router = StartQuizViewRouter(view: QuizGameViewController())
        return viewController
    }
}
