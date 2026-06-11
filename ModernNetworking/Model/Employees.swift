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

// MARK: - Support

struct Support: Codable {
    let url: String?
    let text: String?
}
