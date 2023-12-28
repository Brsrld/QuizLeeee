//
//  StartQuizViewRouter.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation
import UIKit

// MARK: - StartQuizViewRouterProtocol
protocol StartQuizViewRouterProtocol {
    func navigate(viewController: UIViewController)
    var coordinator: Coordinator { get }
}

// MARK: - StartQuizViewRouter StartQuizViewRouterProtocol Extension
final class StartQuizViewRouter: StartQuizViewRouterProtocol {
    
    var coordinator: Coordinator
    
    init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    func navigate(viewController: UIViewController) {
        coordinator.eventOccurred(with: viewController)
    }
}
