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
    
    let testURL = "http://testURL"
    
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
        sut.requestDataFromURL(testURL) { (result: Result<Model, Error>) in }
        
        XCTAssertEqual(mockURLSession.dataTaskCallCount, 1, "Data task call count")
        XCTAssertEqual(mockURLSession.dataTaskArgsRequest.first, URLRequest(url:  URL(string:testURL)!), "testing request")
    }
    
    func test_callingRequestDataFromURLWithSuccessResponse_shouldReturnResults() {
        var testResponse: Model?
        let successHandlerCalled = expectation(description: "Success closure expectation")
        sut.requestDataFromURL(testURL) { (result: Result<Model, Error>) in
            switch result {
            case .success(let model):
                testResponse = model
                successHandlerCalled.fulfill()
            case .failure(_):
                XCTFail("Unexpected error response")
            }
        }
        mockURLSession.dataTaskArgsCompletionHandler.first?(
            jsonData(), response(statusCode: 200), nil
        )
        
        waitForExpectations(timeout: 0.01)
        XCTAssertEqual(testResponse?.data.children.count, 1)
        XCTAssertEqual(testResponse?.data.children.first?.data.title, "test title")
    }
    
    private func response(statusCode: Int) -> HTTPURLResponse? {
        HTTPURLResponse(url: URL(string: "http://testURL")!,
                        statusCode: statusCode,
                        httpVersion: nil,
                        headerFields: nil)
    }
    
    private func jsonData() -> Data {
    """
    {
        "data": {
            "children": [{
                    "data": {
                        "title": "test title"
                    }
            }]
        }
    }
    """.data(using: .utf8)!
    }
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
