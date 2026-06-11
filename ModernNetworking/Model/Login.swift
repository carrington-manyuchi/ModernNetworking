//
//  Login.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation


// MARK: - Login DTOs (Data Transfer Objects)
struct LoginRequest: Encodable {
    let email: String
    let password: String
}

// MARK: - Login
struct Login: Codable {
    let token: String
}
