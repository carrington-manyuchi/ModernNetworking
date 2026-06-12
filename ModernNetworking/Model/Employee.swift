//
//  Employee.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation

struct Employee: Codable, Hashable {
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
