//
//  Motocycle.swift
//  Users
//
//  Created by Axity on 14/05/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import Foundation

struct MotorcycleResponse: Codable {
    var _id: String
    var brand: String
    var name: String
    var displacement: Int
    var maximumSpeed: Int
    var finalTranssmition: Int
    var fuelCapacity: Int
    var maximunPower: Double
    var image: String
}

struct MotorcycleRequest {
    var brand: String
    var name: String
    var displacement: Int
    var maximumSpeed: Int
    var finalTranssmition: Int
    var fuelCapacity: Int
    var maximunPower: Double
    var image: String
}
