//
//  UserResponse.swift
//  Users
//
//  Created by Axity on 27/04/20.
//  Copyright © 2020 Axity. All rights reserved.
//

import UIKit

// MARK: - Welcome
struct UserResponse: Codable {
    let page, perPage, total, totalPages: Int
    let data: [Datum]
    let ad: Ad

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, ad
    }
}

// MARK: - Ad
struct Ad: Codable {
    let company: String
    let url: String
    let text: String
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}
