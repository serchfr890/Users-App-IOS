//
//  User.swift
//  Users
//
//  Created by Axity on 25/04/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

class User {
    let id: Int
    let name: String
    let surname: String
    let emailAddress: String
    let userPhoto: String
    
    init(id: Int, name: String, surname: String, emailAddress: String,userPhoto: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.emailAddress = emailAddress
        self.userPhoto = userPhoto
    }
}
