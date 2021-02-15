//
//  AgendumUITests.swift
//  AgendumUITests
//
//  Created by Sian Pike on 15/02/2021.
//  Copyright © 2021 Sian Pike. All rights reserved.
//

import XCTest

class AgendumUITests: XCTestCase {
    
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginSuccess() throws {
        // UI tests must launch the application that they test.
        app = XCUIApplication()
        let email = app.textFields["U s e r n a m e  o r  E m a i l"]
        let password = app.secureTextFields["P a s s w o r d"]
        let signIn = app.buttons["S I G N  I N"]
        let loginScreen = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        app.launch()
        email.tap()
        email.typeText("sian.pike@icloud.com")
        password.tap()
        password.typeText("test@1234")
        signIn.tap()
        XCTAssertFalse(loginScreen.isHittable)
    }
    
    func testLoginFail() throws {
        
        app = XCUIApplication()
        let signIn = app.buttons["S I G N  I N"]
        let scrollViewsQuery = app.alerts["Authentication Error"].scrollViews
        
        app.launch()
        signIn.tap()
        XCTAssertTrue(scrollViewsQuery.otherElements.containing(.staticText, identifier: "Authentication Error").element.exists)
    }
    
    func testFacebookLogin() throws {
        
        app = XCUIApplication()
        let facebook = app.buttons["Continue with Facebook"]
        let facebookAlert = app.alerts["“Agendum” Wants to Use “facebook.com” to Sign In"]
        let facebookLoginWindow = app.webViews.webViews.webViews.otherElements["Log in to Facebook | Facebook"]
        
        app.launch()
        facebook.tap()
        
        addUIInterruptionMonitor(withDescription: "") { alert -> Bool in

            if facebookAlert.buttons["Continue"].exists { //doesnt get here second time

                facebookAlert.buttons["Continue"].tap()

                return true
            }

            return false
        }
        
        app.activate()
        XCTAssertTrue(facebookLoginWindow.exists)
    }
}
