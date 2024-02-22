//
//  SwiftExampleUITests.swift
//  SwiftExampleUITests
//
//  Created by 200OK-IOS5 on 31/01/24.
//

import XCTest

final class SwiftExampleUITests: XCTestCase {
    let app = XCUIApplication()
    let textfieldUserName: UITextField? = nil
    let textfieldPassword: UITextField? = nil
    
    struct TestFailureMessage {
          static let userNameEmpty = "empty username"
          static let passwordEmpty = "empty password"
      }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        
        textfieldUserName?.accessibilityIdentifier = "txtUserName"
        textfieldPassword?.accessibilityIdentifier = "txtPassword"
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        app.launch()
        
        let app = XCUIApplication()
        app.textFields["Enter username"].tap()
        let userNameTextField = app.textFields["txtUserName"]
        XCTAssertTrue(userNameTextField.exists, TestFailureMessage.userNameEmpty)
        userNameTextField.typeText("dd")
        
        app.secureTextFields["Enter password"].tap()
        
        let loginButton = app.buttons["loginbutton"]
        XCTAssertTrue(loginButton.exists, TestFailureMessage.userNameEmpty)
        loginButton.tap()
            
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
