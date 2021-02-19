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

    func testSignInSuccess() throws {
        
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
    
    func testSignInFail() throws {
        
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
        
        app.launch()
        facebook.tap()
        
        addUIInterruptionMonitor(withDescription: "System Dialog") {
            
            (alert) -> Bool in
            
            XCTAssertTrue(alert.isEnabled)
        
            return true
        }
    }
    
    func testSignUpButton() throws {
        
        app = XCUIApplication()
        
        let signUpButton = app.buttons["S I G N  U P"]
        let signUpView = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        app.launch()
        signUpButton.tap()
        XCTAssertTrue(signUpView.isEnabled)
    }
    
    func testSignUpSuccess() throws {
        
        app = XCUIApplication()
        
        let usernameField = app.textFields["U s e r n a m e"]
        let emailField = app.textFields["E m a i l"]
        let passwordField = app.secureTextFields["P a s s w o r d"]
        let createAccountButton = app.buttons["C R E A T E  A C C O U N T"]
        let dashboard = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .button).element(boundBy: 5)
        
        try testSignUpButton()
        
        usernameField.tap()
        usernameField.typeText("b")
        emailField.tap()
        emailField.typeText("b@test.com")
        passwordField.tap()
        passwordField.typeText("test@1234")
        createAccountButton.tap()
        XCTAssertTrue(dashboard.isEnabled)
    }
    
    func testSignUpFail() throws {
        
        app = XCUIApplication()
        
        let signUpButton = app.buttons["C R E A T E  A C C O U N T"]
        let scrollViewsQuery = app.alerts["Authentication Error"].scrollViews
        
        app.launch()
        
        try testSignUpButton()
        
        signUpButton.tap()
        XCTAssertTrue(scrollViewsQuery.otherElements.containing(.staticText, identifier: "Authentication Error").element.exists)
    }
    
    func testSignInButton() throws {
        
        app = XCUIApplication()
        
        let signInButton = app.buttons["S I G N  I N"]
        let signInView = app.windows.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        app.launch()
        
        try testSignUpButton()
        
        signInButton.tap()
        XCTAssertTrue(signInView.isEnabled)
    }
    
    func testFacebookSignUp() throws {
        
        app = XCUIApplication()
        
        let facebook = app.buttons["Continue with Facebook"]
        
        app.launch()
        
        try testSignUpButton()
        
        facebook.tap()
        
        addUIInterruptionMonitor(withDescription: "System Dialog") {
            
            (alert) -> Bool in
            
            XCTAssertTrue(alert.isEnabled)
        
            return true
        }
    }
}
