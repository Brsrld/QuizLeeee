//
//  CoordinatorProtocol.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import Foundation
import UIKit

protocol CoordinatorProtocol {
    var navigationController: UINavigationController? { get set }
    var parentCoordinator: CoordinatorProtocol? { get set }
    func eventOccurred(with viewController: UIViewController)
    func start()
}
