//
//  Employees.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation

// MARK: - Employees
struct Employees: Codable {
    let page, perPage, total, totalPages: Int?
    let data: [Employee]?
    let support: Support?

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Datum
struct Employee: Codable {
    let id: Int?
    let email, firstName, lastName: String?
    let avatar: String?

    enum CodingKeys: String, CodingKey {
        case id, email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
}


// Update User DTOs
struct UpdateUserRequest: Encodable {
    let firstName: String
    let lastName: String
    let email: String
}


// MARK: - Support
struct Support: Codable {
    let url: String?
    let text: String?
}






// MARK: - UserColor
struct UserColor: Codable {
    let page, perPage, total, totalPages: Int
    let data: [Color]
    let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - Color
struct Color: Codable {
    let id: Int
    let name: String
    let year: Int
    let color, pantoneValue: String

    enum CodingKeys: String, CodingKey {
        case id, name, year, color
        case pantoneValue = "pantone_value"
    }
}


struct UserInfo: Codable {
    let userLoginToken: String
    var personalDetails: PersonalDetails?
    var additionalInformation: AdditionalInformation?
}

struct PersonalDetails: Codable {
    let id: Int
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?
    let dob: String?
    var gender: String?

    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
        case dob = "DOB"
        case gender
    }
}

struct AdditionalInformation: Codable {
    let placeOfBirth: String?
    var preferredColor: String?
    var residentialAddress: String?

    enum CodingKeys: String, CodingKey {
        case placeOfBirth = "placeOfBirth"
        case preferredColor = "preferredColor"
        case residentialAddress = "residentialAddress"
    }
}


// MARK: - UserRequest
struct UserRequest: Codable {
    let username: String
    let password: String
}
