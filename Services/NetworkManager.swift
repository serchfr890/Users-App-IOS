//
//  NetworkManager.swift
//  Users
//
//  Created by Axity on 27/04/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit
import Alamofire
class NetworkManager: NSObject {
    
    private var urlString = "https://reqres.in"
    
    func doLogin(emailAddress: String, password: String, completion: @escaping (Int?) -> Void) -> Void {
        urlString = "\(urlString)/api/login"
        
        AF.request(urlString, method: .post, parameters: ["email":emailAddress, "password":password], encoding: JSONEncoding.default).response { response in
            completion(response.response?.statusCode)
        }
        
    }
    
    func getAllUsers(completion: @escaping ([User]?) -> Void) -> Void {
        var userArray: [User] = []
        urlString = "\(urlString)/api/users?page=2"
        
        AF.request(urlString, method: .get, encoding: JSONEncoding.default).response { response in
            guard let data = response.data else {return}
            
            do {
                let decoder = JSONDecoder()
                let usersResponse = try decoder.decode(UserResponse.self, from: data)

                for users in usersResponse.data {
                    let user = User(id: users.id, name: users.firstName, surname: users.lastName, emailAddress: users.email, userPhoto: users.avatar)
                    userArray.append(user)
                }
                completion(userArray)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
}
