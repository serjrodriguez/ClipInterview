//
//  MockURLSession.swift
//  ClipInterviewTests
//
//  Created by Sergio Andres Rodriguez Castillo on 31/03/24.
//

@testable import ClipInterview
import Foundation

class MockURLSession: URLSessionProtocol {
    var dataTaskCallCount = 0
    var dataTaskArgsRequest: [URLRequest] = []
    
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, (any Error)?) -> Void) -> URLSessionDataTask {
        dataTaskCallCount += 1
        dataTaskArgsRequest.append(request)
        return DummyURLSessionDataTask()
    }
}

class DummyURLSessionDataTask: URLSessionDataTask {
    override func resume() { }
}
