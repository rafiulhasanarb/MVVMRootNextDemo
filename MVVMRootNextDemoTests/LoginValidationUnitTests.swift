//
//  LoginValidationUnitTests.swift
//  MVVMRootNextDemoTests
//
//  Created by rafiul hasan on 21/8/23.
//

import XCTest
@testable import MVVMRootNextDemo

final class LoginValidationUnitTests: XCTestCase {
    
    func test_LoginValidation_With_EmptyStrings_Returns_ValidationFailure() {
        let validation = LoginValidation()
        let request = LoginRequest(userEmail: "", userPassword: "")
        let result = validation.validate(request: request)
        
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "email or password cannot be empty")
    }
    
    func test_LoginValidation_With_EmptyEmail_Returns_ValidationFailure() {
        let validation = LoginValidation()
        let request = LoginRequest(userEmail: "", userPassword: "test")
        let result = validation.validate(request: request)
        
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "email or password cannot be empty")
    }
    
    func test_LoginValidation_With_EmptyPassword_Returns_ValidationFailure() {
        let validation = LoginValidation()
        let request = LoginRequest(userEmail: "test", userPassword: "")
        let result = validation.validate(request: request)
        
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "email or password cannot be empty")
    }
    
    func test_LoginValidation_With_InvalidEmailId_Returns_ValidationFailure() {
        let validation = LoginValidation()
        let request = LoginRequest(userEmail: "test", userPassword: "test")
        let result = validation.validate(request: request)
        
        XCTAssertFalse(result.isValid)
        XCTAssertNotNil(result.message)
        XCTAssertEqual(result.message, "email id is invalid")
    }
    
    func test_LoginValidation_With_ValidRequest_Returns_Success() {
        let validation = LoginValidation()
        let request = LoginRequest(userEmail: "codecat15@gmail.com", userPassword: "test")
        let result = validation.validate(request: request)
        
        XCTAssertTrue(result.isValid)
        XCTAssertNil(result.message)
    }
}
