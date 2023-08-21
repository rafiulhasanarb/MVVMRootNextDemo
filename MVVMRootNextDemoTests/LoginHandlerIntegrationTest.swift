//
//  LoginHandlerIntegrationTest.swift
//  MVVMRootNextDemoTests
//
//  Created by rafiul hasan on 21/8/23.
//

import XCTest
@testable import MVVMRootNextDemo

class LoginHandlerIntegrationTest: XCTestCase {
    
    func test_LoginHandler_WithValidRequest_Returns_LoginData() {
        let request = LoginRequest(userEmail: "codecat15@gmail.com", userPassword: "1234")
        let handler = LoginViewModel()
        let loginExpectations = expectation(description: "WithValidRequest_Returns_LoginData")

        handler.authenticateUser(request: request) { (loginData) in
            XCTAssertNotNil(loginData)
            XCTAssertNil(loginData?.errorMessage)
            XCTAssertEqual(request.userEmail, loginData?.response?.data?.email)
            XCTAssertEqual("codecat15", loginData?.response?.data?.userName)
            XCTAssertEqual(15, loginData?.response?.data?.userID)
            loginExpectations.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_LoginHandler_WithInValidRequest_Returns_Error() {
        let request = LoginRequest(userEmail: "test@test.com", userPassword: "1234")
        let handler = LoginViewModel()
        let loginExpectations = expectation(description: "WithInValidRequest_Returns_Error")
        
        handler.authenticateUser(request: request) { (loginData) in
            XCTAssertNotNil(loginData)
            XCTAssertNil(loginData?.errorMessage)
            XCTAssertNotNil(loginData?.response?.errorMessage)
            XCTAssertNil(loginData?.response?.data)
            XCTAssertEqual("Invalid userEmail and password, please try again", loginData?.response?.errorMessage)
            loginExpectations.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_LoginHandler_WithEmptyString_Returns_Error() {
        let request = LoginRequest(userEmail: "", userPassword: "")
        let handler = LoginViewModel()
        let loginExpectations = expectation(description: "WithEmptyString_Returns_Error")
        
        handler.authenticateUser(request: request) { (loginData) in
            XCTAssertNotNil(loginData)
            XCTAssertNotNil(loginData?.errorMessage)
            XCTAssertNil(loginData?.response)
            XCTAssertEqual("email or password cannot be empty", loginData?.errorMessage)
            loginExpectations.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func test_LoginHandler_WithInvalidEmailId_Returns_Error() {
        let request = LoginRequest(userEmail: "helloWorld", userPassword: "1234")
        let handler = LoginViewModel()
        let loginExpectations = expectation(description: "WithInvalidEmailId_Returns_Error")
        
        handler.authenticateUser(request: request) { (loginData) in
            XCTAssertNotNil(loginData)
            XCTAssertNotNil(loginData?.errorMessage)
            XCTAssertNil(loginData?.response)
            XCTAssertEqual("email id is invalid", loginData?.errorMessage)
            loginExpectations.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
