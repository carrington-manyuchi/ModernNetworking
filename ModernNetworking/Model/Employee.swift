//
//  Employee.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation

struct Employee: Codable, Hashable {
    let id: Int?
    let email: String?
    let firstName: String?
    let lastName: String?
    let avatar: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case avatar
    }
    
    var fullName: String {
        return "\(firstName ?? "") \(lastName ?? "")".trimmingCharacters(in: .whitespaces)
    }
}
