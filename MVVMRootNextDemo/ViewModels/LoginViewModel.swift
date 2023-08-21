//
//  LoginViewModel.swift
//  MVVMRootNextDemo
//
//  Created by rafiul hasan on 17/8/23.
//

import Foundation

protocol LoginViewModelDelegate {
    func didReceiveLoginResponse(loginResponse: LoginResponse?)
}

struct LoginViewModel {
    var delegate : LoginViewModelDelegate?
    let validation = LoginValidation()
    let loginResource = LoginResource()
    
    func authenticateUser(request: LoginRequest, completionHandler: @escaping(_ loginData: LoginData?)->()) {
        let validationResult = validation.validate(request: request)
        if(validationResult.isValid) {
            loginResource.authenticateUser(request: request) { (response) in
                if response?.errorMessage == nil && response?.data != nil {
                    UserDefaultUtility().saveUser(user: (response?.data)!)
                    completionHandler(LoginData(errorMessage: nil, response: response))
                }
            }
        }else{
            completionHandler(LoginData(errorMessage: validationResult.message, response: nil))
        }
        self.delegate?.didReceiveLoginResponse(loginResponse: LoginResponse(errorMessage: validationResult.message, data: nil))
    }
}
