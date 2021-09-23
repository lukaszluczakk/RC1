//
//  FMUITests.swift
//  FMUITests
//
//  Created by Łukasz Łuczak on 31/08/2021.
//

import XCTest
@testable import FM

class FMUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        app = XCUIApplication()
        app.launchArguments.append(CommandLineArgument.uiTest.rawValue)
        app.launch()
        continueAfterFailure = false
    }
    
    func testTableViewShouldhaveTwoCells() {
        let tableCellCount = app.tables["MainTable"].cells.count
        XCTAssertEqual(2, tableCellCount)
    }
    
    func testCellShouldHaveFilledFields(){
        let cell = app.tables["MainTable"].cells["1"]
        let modificationDateLabel = cell.staticTexts["1-ModificationDatelabel"].label
        let titleLabel  = cell.staticTexts["1-TitleLabel"].label
        let descriptionLabel  = cell.staticTexts["1-DescriptionLabel"].label
        let photoImageView  = cell.images["1-PhotoImageView"]
        
        XCTAssertEqual("2021-09-06", modificationDateLabel)
        XCTAssertEqual("Title 1", titleLabel)
        XCTAssertEqual("Corned beef shoulder frankfurter", descriptionLabel)
        XCTAssert(photoImageView.exists)
    }
    
    func testTapOnCellShouldOpensWebView() {
        app.tables["MainTable"].cells["1"].tap()
        let webView = app.webViews["WebView"]
        XCTAssert(webView.exists)
    }
}
