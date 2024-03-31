//
//  ServiceManagerTests.swift
//  ClipInterviewTests
//
//  Created by Sergio Andres Rodriguez Castillo on 31/03/24.
//

@testable import ClipInterview
import XCTest

final class ServiceManagerTests: XCTestCase {
    var sut: ServiceManager!
    var mockURLSession: MockURLSession!
    
    override func setUp() {
        super.setUp()
        mockURLSession = MockURLSession()
        sut = ServiceManager()
        sut.session = mockURLSession
    }
    
    override func tearDown() {
        sut = nil
        mockURLSession = nil
        super.tearDown()
    }
    
    func test_callingRequestDataFromURL_shouldMakeDataTaskAndURLRequest() {
        sut.requestDataFromURL("testURL") { (result: Result<TestDecodableStruct, Error>) in }
        
        XCTAssertEqual(mockURLSession.dataTaskCallCount, 1, "Data task call count")
        XCTAssertEqual(mockURLSession.dataTaskArgsRequest.first, URLRequest(url:  URL(string:"testURL")!), "testing request")
    }
}

private struct TestDecodableStruct: Decodable {
    
}

final class MockServiceManager: ServiceManagerProtocol {
    var requestDataFromUrlCalledTimes = 0
    var completionHandlerCalledWithSuccessTimes = 0
    var completionHandlerCalledWithErrorTimes = 0
    var shouldReturnSuccessResponse = true
    
    func requestDataFromURL<T>(_ urlString: String, completionHandler: @escaping (Result<T, Error>) -> Void) where T : Decodable {
        requestDataFromUrlCalledTimes += 1
        if shouldReturnSuccessResponse {
            completionHandlerCalledWithSuccessTimes += 1
            completionHandler(.success(makeMockData() as! T))
        } else {
            completionHandlerCalledWithErrorTimes += 1
            let testError = NSError(domain: "Test Domain", code: 999)
            completionHandler(.failure(testError))
        }
    }
}
