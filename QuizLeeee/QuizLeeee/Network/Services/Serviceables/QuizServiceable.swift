//
//  QuizServiceable.swift
//  QuizLeeee
//
//  Created by Barış Şaraldı on 27.12.2023.
//

import Foundation

// MARK: - QuizServiceable
protocol QuizServiceable {
    func fetchQuestions() async -> Result<QuizResponseModel, RequestError>
}

// MARK: - QuizService
struct QuizService: QuizServiceable {

    private let service: HTTPClientProtocol
    
    init(service: HTTPClientProtocol) {
        self.service = service
    }
    
    func fetchQuestions() async -> Result<QuizResponseModel, RequestError> {
        return await service.sendRequest(endpoint: QuizEndpoint(), responseModel: QuizResponseModel.self)

    }
}
