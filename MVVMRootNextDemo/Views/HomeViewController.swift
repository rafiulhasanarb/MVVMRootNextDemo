//
//  HomeViewController.swift
//  MVVMRootNextDemo
//
//  Created by rafiul hasan on 17/8/23.
//

import UIKit

@available(iOS 16.0, *)
class HomeViewController: UIViewController {

    @IBOutlet weak var userNamelbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(didTapLogout))
        self.navigationItem.leftBarButtonItem?.isHidden = true
        
        DispatchQueue.main.async {
            if let data = UserDefaults.standard.data(forKey: "userData") {
                do {
                    let userData = try JSONDecoder().decode(LoginResponseData.self, from: data)
                    self.userNamelbl.text = "Hello \(userData.userName)"
                } catch {
                    print("Unable to Decode userData (\(error))")
                }
            }
        }
    }

    // MARK: - Selectors
    @objc private func didTapLogout() {
        self.alertHome(title: "Logout", message: "Logout Successfully")
        navigationController?.popToRootViewController(animated: true)
    }
    
    func alertHome(title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .cancel)
            alert.addAction(alertAction)
            self.present(alert, animated: true)
        }
    }
}

