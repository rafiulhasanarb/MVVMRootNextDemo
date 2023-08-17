//
//  LoginResource.swift
//  MVVMRootNextDemo
//
//  Created by rafiul hasan on 17/8/23.
//

import Foundation

struct LoginResource {
    func loginUser(loginRequest: LoginRequest, completion: @escaping (_ result: LoginResponse?) -> Void) {
        let loginUrl = URL(string: ApiEndpoints.login)!
        let httpUtility = HttpUtility()
        
        do {
            let loginPostBody = try JSONEncoder().encode(loginRequest)
            httpUtility.postApiData(requestUrl: loginUrl, requestBody: loginPostBody, resultType: LoginResponse.self) { (loginApiResponse) in
                completion(loginApiResponse)
            }
        } catch let error {
            debugPrint(error)
        }
    }
}

struct LoginValidation {
    func Validate(loginRequest: LoginRequest) -> ValidationResult {
        if loginRequest.userEmail!.isEmpty {
            return ValidationResult(success: false, error: "User email is empty")
        }
        
        if loginRequest.userPassword!.isEmpty {
            return ValidationResult(success: false, error: "User password is empty")
        }
        return ValidationResult(success: true, error: nil)
    }
}

struct ValidationResult {
    let success: Bool
    let error : String?
}
