//
//  CaseManUITests.swift
//  CaseManUITests
//
//  Created by Benjamin Ludwig on 31.12.19.
//  Copyright © 2019 nerdoc & codinger GmbH. All rights reserved.
//

import XCTest
import SwiftUI

class CaseManUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUp() {
        continueAfterFailure = false
        app.launch()
    }

    override func tearDown() {
        app.terminate()
    }
    
    func testCases() {
        
        XCTAssert(true)
        /** Note: UI tests are very buggy with Xcode Version 11.3 (11C29). For example: ``
            - When tesing for macOS the value of `TextFields` gets never updated
            - When testing for iOS calling `typeText("my fancy var")`is always ignoring the 2nd characxter */

        app.activate()
        app.textFields.element(boundBy: 0).tap()
        #if targetEnvironment(macCatalyst)
        app.textFields.element(boundBy: 0).typeText("my fancy var")
        app.textFields.element(boundBy: 0).typeKey(XCUIKeyboardKey.enter.rawValue, modifierFlags: [])
        #else
        app.typeText("my fancy var")
        app.keyboards.buttons["Return"].tap()
        #endif

        let textField = app.textFields.element(boundBy: 1)
        XCTAssert(textField.exists, "Textfield does not exist")
        let notNil = NSPredicate(format: "value != nil")
        expectation(for: notNil, evaluatedWith: textField, handler: nil)
        waitForExpectations(timeout: 10, handler: nil)

        XCTAssertEqual(app.textFields.element(boundBy: 1).value as! String, "mFancyVar")
        XCTAssertEqual(app.textFields.element(boundBy: 2).value as! String, "MFancyVar")
        XCTAssertEqual(app.textFields.element(boundBy: 3).value as! String, "m_fancy_var")
        XCTAssertEqual(app.textFields.element(boundBy: 4).value as! String, "M_FANCY_VAR")
        XCTAssertEqual(app.textFields.element(boundBy: 5).value as! String, "m-fancy-var")
        XCTAssertEqual(app.textFields.element(boundBy: 6).value as! String, "M-FANCY-VAR")
    }

    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
