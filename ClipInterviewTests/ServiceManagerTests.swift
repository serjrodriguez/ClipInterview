//
//  ServiceManagerTests.swift
//  ClipInterviewTests
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

@testable import ClipInterview
import XCTest

final class ServiceManagerTests: XCTestCase {

}

final class MockServiceManager: ServiceManagerProtocol {
    var requestDataFromUrlCalledTimes = 0
    var shouldReturnSuccessResponse = true
    
    func requestDataFromURL<T>(_ urlString: String, completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        requestDataFromUrlCalledTimes += 1
        if shouldReturnSuccessResponse {
        } else {
            let testError = NSError(domain: "Test Domain", code: 999)
            completionHandler(.failure(testError))
        }
    }
}
