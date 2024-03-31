//
//  ListViewModelTests.swift
//  ClipInterviewTests
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

@testable import ClipInterview
import XCTest

final class ListViewModelTests: XCTestCase {
    var sut: ListViewModel!
    var mockServiceManager: MockServiceManager!
    
    override func setUp() {
        super.setUp()
        mockServiceManager = MockServiceManager()
        sut = ListViewModel(serviceManager: mockServiceManager)
    }
    
    override func tearDown() {
        mockServiceManager = nil
        sut = nil
        super.tearDown()
    }
    
    func test_initialConfiguration() {
        XCTAssertNil(sut.reloadView)
        XCTAssertNil(sut.manageError)
        XCTAssertNil(sut.model)
    }
    
    func test_listViewModel_shouldHaveServiceManagerInstance() {
        XCTAssertNotNil(sut.serviceManager)
    }
    
    func test_requestListDataWithSuccess_shouldExecuteReloadViewHandler() {
        let expectation = expectation(description: "Loading List")
        var reloadViewCalledTimes = 0
        sut.reloadView = {
            reloadViewCalledTimes += 1
            expectation.fulfill()
        }
        sut.requestListData()
        waitForExpectations(timeout: 3)
        
        XCTAssertEqual(reloadViewCalledTimes, 1)
        XCTAssertEqual(sut.model?.data.children.count, 1)
    }
    
    func test_requestListDataWithErrorResponse_shouldCallManageErrorHandler() {
        var manageErrorCalledTimes = 0
        let expectation = expectation(description: "Loading List")
        mockServiceManager.shouldReturnSuccessResponse = false
        sut.manageError = { error in
            manageErrorCalledTimes += 1
            expectation.fulfill()
        }
        sut.requestListData()
        waitForExpectations(timeout: 3)
        
        XCTAssertEqual(manageErrorCalledTimes, 1)
        XCTAssertNil(sut.model)
    }
    
    func test_getDataAtRowWithNilModel_shouldReturnNil() {
        XCTAssertNil(sut.getDataAtRow(0))
    }
    
    func test_getDataAtRowWithOneRegiter_shouldReturnObjectAtThatPosition() throws {
        sut.model = makeMockData()
        let childrenData = try XCTUnwrap(sut.getDataAtRow(0))
        
        XCTAssertEqual(childrenData.data.title, "Test title 1")
    }
    
    func test_getDataAtRow44_shouldReturnObjectAtThatPosition() throws {
        sut.model = makeMockData(100)
        let childrenData = try XCTUnwrap(sut.getDataAtRow(44))
        
        XCTAssertEqual(childrenData.data.title, "Test title 45")
    }
    
    func test_getNumberOfRowsWithNilModel_shouldReturnZero() {
        XCTAssertEqual(sut.getNumberOfRows(), 0)
    }
    
    func test_getNumberOfRowsWithOneModel_shouldReturnOne() {
        sut.model = makeMockData()
        XCTAssertEqual(sut.getNumberOfRows(), 1)
    }
    
    func test_getNumberOfRowsWith100Resgisters_shouldReturn100() {
        sut.model = makeMockData(100)
        XCTAssertEqual(sut.getNumberOfRows(), 100)
    }
}

final class MockListViewModel: ListViewModelProtocol {
    var getNumberOfRowsCalledTimes = 0
    var getDataAtRowCalledTimes = 0
    var requestListDataCalledTimes = 0
    var reloadViewArgsAccumulator: [(() -> Void)] = []
    var managerErrorArgsAccumulator: [((Error) -> Void)] = []
    
    var reloadView: (() -> Void)? {
        didSet {
            if let reloadView = reloadView {
                reloadViewArgsAccumulator.append(reloadView)
            }
        }
    }
    var manageError: ((Error) -> Void)? {
        didSet {
            if let manageError = manageError {
                managerErrorArgsAccumulator.append(manageError)
            }
        }
    }
    func requestListData() {
        requestListDataCalledTimes += 1
    }
    
    func getNumberOfRows() -> Int {
        getNumberOfRowsCalledTimes += 1
        return 0
    }

    func getDataAtRow(_ row: Int) -> ChildrenData? {
        getDataAtRowCalledTimes += 1
        return nil
    }
}
