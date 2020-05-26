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
    
    // MARK: - Variables
    private var urlString = COMMON_MESSAGES.EMPTY
    
    // MARCK: - USERS
    func doLogin(emailAddress: String, password: String, completion: @escaping (Int?) -> Void) -> Void {
        urlString = "\(NETWORK_CONSTANST.URL_BASE_USERS)/api/login"
        
        AF.request(urlString, method: .post, parameters: ["email":emailAddress, "password":password], encoding: JSONEncoding.default).response { response in
            completion(response.response?.statusCode)
        }
        
    }
    
    func getAllUsers(completion: @escaping ([User]?) -> Void) -> Void {
        var userArray: [User] = []
        urlString = "\(NETWORK_CONSTANST.URL_BASE_USERS)/api/users?page=2"
        
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
    
    // MARCK: CRUD
    func getAllMotocycles(completion: @escaping ([MotorcycleResponse]?) -> Void) -> Void {
        
        let crudUrl = "\(NETWORK_CONSTANST.CRUD_BASE_URL)\(NETWORK_CONSTANST.ENDPOINT_IDENTIFIER)/\(NETWORK_CONSTANST.RESOURCE_CRUD)"
        var motorCycleArray: [MotorcycleResponse] = []
        AF.request(crudUrl, method: .get).response { response in
            guard let data = response.data else {return}
            do {
                let decoder = JSONDecoder()
                let motorcycleResponse = try decoder.decode([MotorcycleResponse].self, from: data)
                
                for motocycles in motorcycleResponse {
                    
                    let motocycle = MotorcycleResponse(_id: motocycles._id, brand: motocycles.brand, displacement: motocycles.displacement, finalTranssmition: motocycles.finalTranssmition, fuelCapacity: motocycles.fuelCapacity, maximumSpeed: motocycles.maximumSpeed, maximunPower: motocycles.maximunPower, name: motocycles.name)
                    motorCycleArray.append(motocycle)
                }
                completion(motorCycleArray)
            } catch let error {
                print(error)
                completion(nil)
            }
        }
    }
    
    
    func createMotorcycle (motorcycle: MotorcycleRequest, completion: @escaping (Int?) -> Void) -> Void  {
        let crudUrl = "\(NETWORK_CONSTANST.CRUD_BASE_URL)\(NETWORK_CONSTANST.ENDPOINT_IDENTIFIER)/\(NETWORK_CONSTANST.RESOURCE_CRUD)"

        AF.request(crudUrl, method: .post, parameters: motorcycle , encoder: JSONParameterEncoder.sortedKeys).response { response in
            completion(response.response?.statusCode)
        }
    }
    
    func updateMotocycle(id: String,  motorcycle: MotorcycleRequest, completion: @escaping(Int?) -> Void) -> Void {
        let crudUrl = "\(NETWORK_CONSTANST.CRUD_BASE_URL)\(NETWORK_CONSTANST.ENDPOINT_IDENTIFIER)/\(NETWORK_CONSTANST.RESOURCE_CRUD)/\(id)"
        
        AF.request(crudUrl, method: .put, parameters: motorcycle, encoder: JSONParameterEncoder.sortedKeys).response { response in
            completion(response.response?.statusCode)
        }
    }
    
    func deleteMotocycle(id: String, completion: @escaping(Int?) -> Void) -> Void {
        let crudUrl = "\(NETWORK_CONSTANST.CRUD_BASE_URL)\(NETWORK_CONSTANST.ENDPOINT_IDENTIFIER)/\(NETWORK_CONSTANST.RESOURCE_CRUD)/\(id)"
AF.request(crudUrl, method: .delete, encoding: JSONEncoding.default).response {
            response in
            completion(response.response?.statusCode)
        }
    }
    
}
