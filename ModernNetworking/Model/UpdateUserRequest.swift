//
//  UpdateUserRequest.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation

struct UpdateUserRequest: Encodable {
    let firstName: String
    let lastName: String
    let email: String
}
