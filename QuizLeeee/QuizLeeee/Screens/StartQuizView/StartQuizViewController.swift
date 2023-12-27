//
//  StartQuizViewController.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import UIKit

final class StartQuizViewController: UIViewController {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var scoreLabel: UILabel!
    var router: StartQuizViewRouter?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareUI()
    }
    
    private func prepareUI() {
        imageView.image = UIImage(named: "hbImage")
        imageView.contentMode = .scaleAspectFill
    }
    
    @IBAction private func StartButton(_ sender: Any) {
        router?.navigate()
    }
}
