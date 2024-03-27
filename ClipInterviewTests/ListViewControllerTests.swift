//
//  ListViewControllerTests.swift
//  ClipInterviewTests
//
//  Created by Sergio Andres Rodriguez Castillo on 27/03/24.
//

@testable import ClipInterview
import XCTest

final class ListViewControllerTests: XCTestCase {
    var sut: ListViewController!
    var mockViewModel: MockListViewModel!
    
    override func setUp() {
        super.setUp()
        mockViewModel = MockListViewModel()
        sut = ListViewController(viewModel: mockViewModel)
    }
    
    override func tearDown() {
        sut = nil
        mockViewModel = nil
        super.tearDown()
    }
    
    func test_initializeListViewController_shouldHaveViewModel() {
        XCTAssertNotNil(sut.viewModel)
    }
    
    func test_listViewControllerTableViewInitialConfiguration() {
        XCTAssertNotNil(sut.tableView)
        XCTAssertNil(sut.tableView.delegate)
        XCTAssertNil(sut.tableView.dataSource)
        XCTAssertFalse(sut.tableView.translatesAutoresizingMaskIntoConstraints)
    }
    
    func test_callingListTableViewControllerViewDidLoad_shouldConfigureTableView() {
        sut.viewDidLoad()
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func test_callingListViewControllerViewDidLoad_shouldBindViewModel() {
        XCTAssertNil(mockViewModel.manageError)
        XCTAssertNil(mockViewModel.reloadView)
        sut.viewDidLoad()
        XCTAssertNotNil(mockViewModel.manageError)
        XCTAssertNotNil(mockViewModel.reloadView)
    }
    
    func test_listViewController_shouldHaveTitle() {
        sut.viewDidLoad()
        XCTAssertEqual(sut.title, "List View")
    }
}
