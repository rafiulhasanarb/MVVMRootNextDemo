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
    
    func loginUser(loginRequest: LoginRequest) {
        let validationResult = LoginValidation().Validate(loginRequest: loginRequest)
        
        if(validationResult.success) {
            //use loginResource to call login API
            let loginResource = LoginResource()
            loginResource.loginUser(loginRequest: loginRequest) { (loginApiResponse) in
                if(loginApiResponse?.errorMessage == nil && loginApiResponse?.data != nil) {
                    UserDefaultUtility().saveUser(user: (loginApiResponse?.data)!)
                }
                //return the response we get from loginResource
                DispatchQueue.main.async {
                    self.delegate?.didReceiveLoginResponse(loginResponse: loginApiResponse)
                }
            }
        }
        self.delegate?.didReceiveLoginResponse(loginResponse: LoginResponse(errorMessage: validationResult.error, data: nil))
    }
}
