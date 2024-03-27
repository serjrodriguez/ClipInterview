//
//  ListViewModelTests.swift
//  ClipInterviewTests
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

@testable import ClipInterview
import XCTest

final class ListViewModelTests: XCTestCase {
    
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
