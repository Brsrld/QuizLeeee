//
//  HttpClientTest.swift
//  QuizLeeeeTests
//
//  Created by Barış Şaraldı on 28.12.2023.
//

import Foundation
@testable import QuizLeeee
import XCTest

class HttpClientTest: XCTestCase {
    var urlSession: URLSession!
    var endpoint: Endpoint!
    var service: HTTPClientProtocol!
    
    let mockString =
    """
    {
        "questions": [
            {
                "question": "Dünyanın 7 Harikası’ndan biri olan İskenderiye Feneri nerede bulunur?",
                "answers": {
                    "A": "Libya",
                    "B": "Yemen",
                    "C": "Sudan",
                    "D": "Mısır"
                },
                "questionImageUrl": null,
                "correctAnswer": "D",
                "score": 200
            }
        ]
    }
    """
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        
        urlSession = URLSession(configuration: config)
        endpoint = QuizEndpoint()
        service = HttpClient(urlSession: urlSession)
    }
    
    override func tearDown() {
        urlSession = nil
        endpoint = nil
        super.tearDown()
    }
    
    func test_Get_Data_Success() async throws {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.url
        urlComponents.path = endpoint.path.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await service.sendRequest(endpoint: endpoint,
                                           responseModel: QuizResponseModel.self)
            switch result {
            case .success(let success):
                XCTAssertEqual(success.questions?.first?.question,"Dünyanın 7 Harikası’ndan biri olan İskenderiye Feneri nerede bulunur?")
                XCTAssertEqual(success.questions?.count, 1)
                expectation.fulfill()
            case .failure(let failure):
                XCTAssertThrowsError(failure)
            }
        }
        await fulfillment(of: [expectation], timeout: 2)
    }
    
    func test_News_BadResponse() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.url
        urlComponents.path = endpoint.path.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 400,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await service.sendRequest(endpoint: endpoint,
                                           responseModel: QuizResponseModel.self)
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let failure):
                XCTAssertEqual(RequestError.unexpectedStatusCode, failure)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 2)
    }
    
    func test_News_EncodingError() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host.url
        urlComponents.path = endpoint.path.path
        urlComponents.queryItems = endpoint.queryItems
        
        let response = HTTPURLResponse(url: urlComponents.url!,
                                       statusCode: 200,
                                       httpVersion: nil,
                                       headerFields: ["Content-Type": "application/json"])!
        
        let mockData: Data = Data(mockString.utf8)
        
        MockURLProtocol.requestHandler = { request in
            return (response, mockData)
        }
        
        let expectation = XCTestExpectation(description: "response")
        
        Task {
            let result = await service.sendRequest(endpoint: endpoint,
                                           responseModel: [QuizResponseModel].self)
            switch result {
            case .success(_):
                XCTAssertThrowsError("Fatal Error")
            case .failure(let failure):
                XCTAssertEqual(RequestError.decode, failure)
                expectation.fulfill()
            }
        }
    }
    
    func test_News_InvalidURL() {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = "endpoint.host.url"
        urlComponents.path = " endpoint.path.path"
        urlComponents.queryItems = endpoint.queryItems
        
        let expectation = XCTestExpectation(description: "url error")
        
        if let url = urlComponents.url {
            _ = HTTPURLResponse(url: url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: ["Content-Type": "application/json"])!
        } else {
            XCTAssertEqual(urlComponents.url, nil)
            expectation.fulfill()
        }
    }
}
