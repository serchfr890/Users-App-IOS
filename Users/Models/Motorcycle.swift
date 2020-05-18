//
//  Motorcycle.swift
//  Users
//
//  Created by Axity on 15/05/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import Foundation


struct MotorcycleResponse: Codable {
    var _id: String
    var brand: String
    var displacement: Int
    var finalTranssmition: Int
    var fuelCapacity: Int
    var image:String
    var maximumSpeed: Int
    var maximunPower: Double
    var name: String
}

struct MotorcycleRequest: Encodable {
    var brand: String
    var displacement: Int
    var finalTranssmition: Int
    var fuelCapacity: Int
    var image:String
    var maximumSpeed: Int
    var maximunPower: Double
    var name: String
}
