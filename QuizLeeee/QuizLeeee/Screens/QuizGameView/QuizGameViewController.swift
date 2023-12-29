//
//  QuizGameViewController.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import UIKit
import Kingfisher

// MARK: - QuizGameViewProtocol
protocol QuizGameViewProtocol {
    func questionOutput()
    func errorOutput(_ output: String)
    func loading()
    func finished()
    func calculateQuestions(tag:Int)
    func updateUI()
    func gameOver()
}

// MARK: - QuizGameViewController
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
    var router: QuizGameRouterProtocol?
    
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
        
        title = Constants.title.text
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    private func prepareUI() {
        guard let index = self.viewModel?.questionIndex,
              let totalQuestion = self.viewModel?.question.count,
              let totalPoint = self.viewModel?.totalPoint,
              let point = self.viewModel?.question[index].score else { return }
        
        self.totalQuestionAndPointsLabel.text = Constants.totalScore(question: index + 1,
                                                                      totalQuestion: totalQuestion,
                                                                      point: totalPoint).text
        
        self.questionLabel.text = self.viewModel?.question[index].question
        self.singleQuestionPoint.text = Constants.singleQuestionPoint(point: point).text
        
        self.buttonA.setTitle(self.viewModel?.question[index].answers?.a, for: .normal)
        self.buttonB.setTitle(self.viewModel?.question[index].answers?.b, for: .normal)
        self.buttonC.setTitle(self.viewModel?.question[index].answers?.c, for: .normal)
        self.buttonD.setTitle(self.viewModel?.question[index].answers?.d, for: .normal)
        
        prepareImage(index: index)
    }
    
    private func prepareImage(index: Int) {
      
        if let imageURL = self.viewModel?.question[index].questionImageURL {
            self.questionImage.kf.setImage(with: URL(string: imageURL)
                                           ,placeholder: UIImage(systemName: Constants.placeHolderImage.text))
        } else {
            self.questionImage.image = UIImage(systemName: Constants.photo.text)
        }
    }
    
    @IBAction private func buttonClick(_ sender: UIButton) {
        self.presenter?.calculateQuestions(tag: sender.tag)
    }
}

// MARK: - QuizGameViewProtocol QuizGameViewProtocol Extension
extension QuizGameViewController: QuizGameViewProtocol {
    
    func gameOver() {
        guard let score = viewModel?.totalPoint else { return }
        viewModel?.saveScore()
        alert(message: Constants.totalScoreMessage(score: score).text,
              title: Constants.gameOverMessage.text ) { [weak self] _ in
            self?.router?.pop()
        }
    }
    
    func updateUI() {
        DispatchQueue.main.async { [weak self] in
            self?.prepareUI()
        }
    }
    
    func calculateQuestions(tag: Int) {
        viewModel?.calculateGameFeatures(tag: tag)
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
    
    func questionOutput() {
        DispatchQueue.main.async { [weak self] in
            self?.prepareUI()
        }
    }
    
    func errorOutput(_ output: String) {
        alert(message: output, handler: nil)
    }
}

// MARK: - Constants
fileprivate enum Constants {
    case title
    case totalScore(question: Int,
                    totalQuestion:Int,
                    point:Int)
    case singleQuestionPoint(point:Int)
    case photo
    case totalScoreMessage(score: Int)
    case gameOverMessage
    case placeHolderImage
    
    var text: String {
        switch self {
        case .title:
            return "Quiz Game"
        case .totalScore(question: let question, totalQuestion: let totalQuestion, point: let point):
            return "Soru \(question)/\(totalQuestion) total puaniniz: \(point)"
        case .singleQuestionPoint(point: let point):
            return String(describing:point) + " puan"
        case .photo:
            return "photo"
        case .totalScoreMessage(score: let score):
            return "Your total score: \(score)"
        case .gameOverMessage:
            return "Game Over"
        case .placeHolderImage:
            return "photo.badge.arrow.down"
        }
    }
}
