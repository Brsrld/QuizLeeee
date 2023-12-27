//
//  QuizResponseModel.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

// MARK: - QuizResponseModel
struct QuizResponseModel: Codable {
    let questions: [Question]?
}

// MARK: - Question
struct Question: Codable {
    let question: String?
    let answers: Answers?
    let questionImageURL: String?
    let correctAnswer: String?
    let score: Int?

    enum CodingKeys: String, CodingKey {
        case question, answers
        case questionImageURL = "questionImageUrl"
        case correctAnswer, score
    }
}

// MARK: - Answers
struct Answers: Codable {
    let a, b, c, d: String?

    enum CodingKeys: String, CodingKey {
        case a = "A"
        case b = "B"
        case c = "C"
        case d = "D"
    }
}
