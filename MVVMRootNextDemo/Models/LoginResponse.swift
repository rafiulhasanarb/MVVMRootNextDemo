//
//  LoginResponse.swift
//  MVVMRootNextDemo
//
//  Created by rafiul hasan on 17/8/23.
//

import Foundation

struct LoginResponse: Decodable {
    let errorMessage: String?
    let data: LoginResponseData?
}

struct LoginResponseData: Codable {
    let userName: String
    let userID: Int
    let email: String

    enum CodingKeys: String, CodingKey {
        case userName
        case userID = "userId"
        case email
    }
}
