//
//  StartQuizViewController.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import UIKit

// MARK: - StartQuizViewProtocol
protocol StartQuizViewProtocol {
    func handleHighScore(_ output: StartQuizGameViewModelProtocol)
}

// MARK: - StartQuizViewController
final class StartQuizViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var scoreLabel: UILabel!
    
    var router: StartQuizViewRouterProtocol?
    var presenter: StartQuizViewPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
        presenter?.fetchHighScore()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.fetchHighScore()
    }
    
    private func prepareUI() {
        imageView.image = UIImage(named: Constants.photo.text)
        imageView.contentMode = .scaleAspectFill
    }
    
    @IBAction private func StartButton(_ sender: Any) {
        guard let coordinator = router?.coordinator else { return }
        let viewcontroller = QuizGameBuilder.build(coordinator: coordinator)
        router?.navigate(viewController: viewcontroller)
    }
}

// MARK: - StartQuizViewController StartQuizViewProtocol Extension
extension StartQuizViewController: StartQuizViewProtocol {
    func handleHighScore(_ output: StartQuizGameViewModelProtocol) {
        scoreLabel.text = Constants.scoreLabel(point: output.highScore).text
    }
}

// MARK: - Constants
fileprivate enum Constants {
    case photo
    case scoreLabel(point:Int)
    
    var text: String {
        switch self {
        case .photo:
            return "hbImage"
        case .scoreLabel(point: let point):
            return "En yüksek puan \(point) puan"
        }
    }
}
