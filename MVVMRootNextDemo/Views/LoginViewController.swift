//
//  LoginViewController.swift
//  MVVMRootNextDemo
//
//  Created by rafiul hasan on 17/8/23.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    
    private var loginViewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loginViewModel.delegate = self
    }

    // MARK: - Login button tapped
    @IBAction func didTapOnLoginButton(_ sender: Any) {
        let request = LoginRequest(userEmail: userName.text!, userPassword: password.text!)
        loginViewModel.authenticateUser(request: request) { loginData in
            if loginData?.errorMessage == nil && loginData?.response?.data != nil {
                DispatchQueue.main.async {
                    self.didReceiveLoginResponse(loginResponse: loginData?.response)
                }
            }
        }
    }
    
}

extension LoginViewController : LoginViewModelDelegate {
    func didReceiveLoginResponse(loginResponse: LoginResponse?) {
        if(loginResponse?.errorMessage == nil && loginResponse?.data != nil) {
            self.performSegue(withIdentifier: "navigateToEmployeeView", sender: nil)
        } else if (loginResponse?.errorMessage != nil) {
            let alert = UIAlertController(title: Constants.ErrorAlertTitle, message: loginResponse?.errorMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: Constants.OkAlertTitle, style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
