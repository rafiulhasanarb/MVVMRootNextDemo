//
//  LoginResource.swift
//  MVVMRootNextDemo
//
//  Created by rafiul hasan on 17/8/23.
//

import Foundation

struct LoginResource {
    
    let loginUrl = URL(string: ApiEndpoints.login)!
    
    func authenticateUser(request: LoginRequest, completionHandler: @escaping(_ result: LoginResponse?)->()) {
        let urlRequest = generateLoginUrlRequest(request: request)
        URLSession.shared.dataTask(with: urlRequest) { (responseData, serverResponse, serverError) in
            if(serverError == nil && responseData != nil){
                do {
                    let result = try JSONDecoder().decode(LoginResponse.self, from: responseData!)
                    completionHandler(result)
                } catch  {
                    debugPrint("Encoding request body failed")
                }
            }
        }.resume()
    }
    
    private func generateLoginUrlRequest(request: LoginRequest) -> URLRequest {
        var urlRequest = URLRequest(url: URL(string: ApiEndpoints.login)!)
        urlRequest.httpMethod = "post"
        
        do {
            urlRequest.httpBody = try JSONEncoder().encode(request)
        } catch  {
            debugPrint("Encoding request body failed")
        }
        
        urlRequest.addValue("application/json", forHTTPHeaderField: "content-type")
        return urlRequest
    }

}
