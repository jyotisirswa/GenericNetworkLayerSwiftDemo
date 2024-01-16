//
//  GenericNetworkLayerAppUITests.swift
//  GenericNetworkLayerAppUITests
//
//  Created by Jyoti - LetsWork on 1/11/24.
//

import XCTest
@testable import GenericNetworkLayerApp

final class GenericNetworkLayerAppUITests: XCTestCase {
    
    private var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launchArguments.append("🚨****** UITest Began ******🚨")
    }
    
    func test_list_view_controller_elements_exist(){
        app.launch()
        //sleep(1)
        XCTAssertTrue(app.isListTableViewDisplayed)
        //XCTAssertTrue(app.islistCellDisplayed)
//        XCTAssertTrue(app.isListCellTitleLabelDisplayed)
//        XCTAssertTrue(app.isListCellTimeNGenreLabelDisplayed)
//        XCTAssertTrue(app.isListCellonMyWatchListDisplayed)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

extension XCUIApplication {
    // MARK: - List View Controller
    var listTableView: XCUIElement! {
        tables["listTableView"]
    }
    
    var isListTableViewDisplayed: Bool {
        listTableView.exists
    }
    
    var listCell: XCUIElement! {
        otherElements["characterImage"]
    }
    
    var islistCellDisplayed: Bool {
        listCell.exists
    }
}
