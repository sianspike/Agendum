//
//  AgendumTests.swift
//  AgendumTests
//
//  Created by Sian Pike on 15/02/2021.
//  Copyright © 2021 Sian Pike. All rights reserved.
//

import XCTest

@testable import Agendum

class AgendumTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func signUp() throws {

        let sut = FirebaseSession()
        
        sut.signUp(email: "abc@test.com", password: "test@1234") { result, error in
            
            XCTAssert((result != nil) || (error != nil))
        }
    }
    
    func signIn() throws {
        
        let sut = FirebaseSession()
        
        sut.signIn(email: "abc@test.com", password: "test@1234") { result, error in
            
            XCTAssert((result != nil) || (error != nil))
        }
    }
}
