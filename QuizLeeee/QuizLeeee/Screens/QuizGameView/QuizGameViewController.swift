//
//  QuizGameViewController.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import UIKit
import Kingfisher

protocol QuizGameViewProtocol {
    func questionOutput(_ output: QuizGameViewModel)
    func errorOutput(_ output: String)
    func loading()
    func finished()
    func calculateQuestions(tag:Int,_ output: QuizGameViewModel)
    func updateUI()
    func gameOver()
}

final class QuizGameViewController: UIViewController {
    
    @IBOutlet weak var middleView: UIView!
    @IBOutlet private weak var totalQuestionAndPointsLabel: UILabel!
    @IBOutlet private weak var singleQuestionPoint: UILabel!
    @IBOutlet private weak var questionImage: UIImageView!
    @IBOutlet private weak var questionLabel: UILabel!
    
    @IBOutlet private weak var buttonA: UIButton!
    @IBOutlet private weak var buttonB: UIButton!
    @IBOutlet private weak var buttonC: UIButton!
    @IBOutlet private weak var buttonD: UIButton!
    
     var presenter: QuizGamePresenterProtocol?
     var viewModel: QuizGameViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        callService()
        initUI()
    }
    
    private func callService() {
        presenter?.fetchQuestions()
    }
    
    private func initUI() {
        questionLabel.numberOfLines = 2
        buttonA.layer.cornerRadius = 8
        buttonB.layer.cornerRadius = 8
        buttonC.layer.cornerRadius = 8
        buttonD.layer.cornerRadius = 8
        
        middleView.clipsToBounds = true
        middleView.layer.cornerRadius = 8
        
        title = "Quiz Game"
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func prepareUI() {
        DispatchQueue.main.async { [weak self] in
            guard let index = self?.viewModel?.questionIndex,
                  let totalQuestion = self?.viewModel?.question.count,
                  let totalPoint = self?.viewModel?.totalPoint,
                  let point = self?.viewModel?.question[index].score else { return }
       
            self?.totalQuestionAndPointsLabel.text = "Soru \(index + 1)/\(String(describing:totalQuestion)) total puaniniz: \(String(describing:totalPoint))"
            self?.questionLabel.text = self?.viewModel?.question[index].question
            self?.singleQuestionPoint.text = String(describing:point) + " puan"
            
            self?.buttonA.setTitle(self?.viewModel?.question[index].answers?.a, for: .normal)
            self?.buttonB.setTitle(self?.viewModel?.question[index].answers?.b, for: .normal)
            self?.buttonC.setTitle(self?.viewModel?.question[index].answers?.c, for: .normal)
            self?.buttonD.setTitle(self?.viewModel?.question[index].answers?.d, for: .normal)
            
        
            if let imageURL = self?.viewModel?.question[index].questionImageURL {
                self?.questionImage.kf.setImage(with: URL(string: imageURL))
            } else {
                self?.questionImage.image = UIImage(systemName: "photo")
            }
        }
    }
    
    @IBAction private func buttonClick(_ sender: UIButton) {
        self.presenter?.calculateQuestions(tag: sender.tag)
    }
}

extension QuizGameViewController: QuizGameViewProtocol {
    func gameOver() {
        guard let score = viewModel?.totalPoint else { return }
        alert(message: "Your total score: \(score)", title: "Game Over") { [weak self] _ in
           /// self?.coordinator?.navigationController?.popViewController(animated: true)
        }
    }
    
    func updateUI() {
        prepareUI()
    }
    
    func calculateQuestions(tag: Int, _ output: QuizGameViewModel) {
        output.calculateGameFeatures(tag: tag)
    }

    func loading() {
        DispatchQueue.main.async { [weak self] in
            self?.view.activityStartAnimating()
        }
    }
    
    func finished() {
        DispatchQueue.main.async { [weak self] in
            self?.view.activityStopAnimating()
        }
    }
    
    func questionOutput(_ output: QuizGameViewModel) {
        self.viewModel = output
        prepareUI()
    }
    
    func errorOutput(_ output: String) {
        alert(message: output, handler: nil)
    }
}
