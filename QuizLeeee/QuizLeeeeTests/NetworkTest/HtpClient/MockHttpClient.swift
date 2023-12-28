//
//  MockHttpClient.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import Foundation
@testable import QuizLeeee

final class MockHttpClient: QuizServiceable {
    
    let filename: String
    private let service: Mockable
    
    init(filename: String, service: Mockable) {
        self.filename = filename
        self.service = service
    }
    
    func fetchQuestions() async -> Result<QuizLeeee.QuizResponseModel, QuizLeeee.RequestError> {
        return await service.loadJson(filename: filename,
                              extensionType: .json,
                              responseModel: QuizLeeee.QuizResponseModel.self)
    }
}
