//
//  StartQuizViewController.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import UIKit

protocol StartQuizViewProtocol {
    func handleHighScore(_ output: StartQuizGameViewModelProtocol)
}

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
        imageView.image = UIImage(named: "hbImage")
        imageView.contentMode = .scaleAspectFill
    }
    
    @IBAction private func StartButton(_ sender: Any) {
        guard let coordinator = router?.coordinator else { return }
        let viewcontroller = QuizGameBuilder.build(coordinator: coordinator)
        router?.navigate(viewController: viewcontroller)
    }
}

extension StartQuizViewController: StartQuizViewProtocol {
    func handleHighScore(_ output: StartQuizGameViewModelProtocol) {
        scoreLabel.text = "En yüksek puan \(output.highScore) puan"
    }
}
