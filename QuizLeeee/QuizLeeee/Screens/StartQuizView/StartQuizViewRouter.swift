//
//  StartQuizViewRouter.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation
import UIKit

protocol StartQuizViewRouterProtocol {
    func navigate()
}

final class StartQuizViewRouter: StartQuizViewRouterProtocol {
    let view: UIViewController
    
    init( view: UIViewController) {
        self.view = view
    }
    
    func navigate() {
        let viewController = QuizGameBuilder.build()
        view.navigationController?.pushViewController(viewController, animated: true)
    }
}
