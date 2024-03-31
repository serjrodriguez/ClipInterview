//
//  BaseViewControllerTests.swift
//  ClipInterviewTests
//
//  Created by Sergio Andres Rodriguez Castillo on 31/03/24.
//

@testable import ClipInterview
import XCTest
import ViewControllerPresentationSpy

final class BaseViewControllerTests: XCTestCase {
    
    var sut: BaseViewController!
    var alertVerifier: AlertVerifier!
    
    @MainActor override func setUp() {
        super.setUp()
        sut = BaseViewController(nibName: nil, bundle: nil)
        alertVerifier = AlertVerifier()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        executeRunLoop()
        sut = nil
        alertVerifier = nil
        super.tearDown()
    }
    
    @MainActor func test_alertPresented() {
        let testTitle = "Test Title"
        let testMessage = "Test message"
        let testFirstActionTitle = "Test first action title"
        let testSecondActionTitle = "Test second action title"
        
        sut.presentAlertWithTitle(testTitle,
                                  message: testMessage,
                                  firstActionTitle: testFirstActionTitle,
                                  secondActionTitle: testSecondActionTitle)
        
        verifyAlertPresented(title: testTitle, message: testMessage)
    }
    
    @MainActor private func verifyAlertPresented(
        title: String,
        message: String,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        alertVerifier.verify(
            title: title,
            message: message,
            animated: true,
            actions: [
                .default("Test first action title"),
                .cancel("Test second action title")
            ],
            presentingViewController: sut,
            file: file,
            line: line
        )
        XCTAssertEqual(alertVerifier.preferredAction?.title, "Test first action title", "prefered action", file: file, line: line)
    }
}
