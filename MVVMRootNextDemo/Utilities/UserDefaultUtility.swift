//
//  UserDefaultUtility.swift
//  MVVMRootNextDemo
//
//  Created by rafiul hasan on 17/8/23.
//

import Foundation

struct UserDefaultUtility {
    func saveUserId(userId: Int) {
        UserDefaults.standard.set(userId, forKey: "userId")
    }
    
    func getUserId() -> Int {
        return UserDefaults.standard.value(forKey: "userId") as! Int
    }
    
    func saveUser(user: LoginResponseData) {
        do {
            let data = try JSONEncoder().encode(user)
            UserDefaults.standard.set(data, forKey: "userData")
        } catch {
            print("Unable to Encode userData (\(error))")
        }
    }
}
