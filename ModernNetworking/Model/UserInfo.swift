//
//  UserInfo.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation

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
