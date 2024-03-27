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
    
    func requestDataFromURL<T>(_ urlString: String, completionHandler: @escaping (Result<T, any Error>) -> Void) where T : Decodable {
        requestDataFromUrlCalledTimes += 1
    }
}
