//
//  Coordinator.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import Foundation
import UIKit

final class Coordinator: CoordinatorProtocol {
    
    // MARK: Properties
    var parentCoordinator: CoordinatorProtocol?
    var children: [CoordinatorProtocol] = []
    var navigationController: UINavigationController?
    
    // MARK: Functions
    func start() {
        let vc = StartQuizViewBuilder.build(coordinator: self)
        navigationController?.setViewControllers([vc],
                                                 animated: true)
    }

    func eventOccurred(with viewController: UIViewController) {
        navigationController?.pushViewController(viewController,
                                                 animated: true)
    }
}
