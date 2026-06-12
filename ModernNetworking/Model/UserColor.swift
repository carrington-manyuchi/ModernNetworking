//
//  UserColor.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation

// MARK: - UserColor
struct UserColor: Codable {
    let page, perPage, total, totalPages: Int
    let data: [ColorResponse]  
    let support: Support

    enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

// MARK: - ColorResponse
struct ColorResponse: Codable {  // 👈 Renamed to ColorResponse
    let id: Int
    let name: String
    let year: Int
    let color, pantoneValue: String

    enum CodingKeys: String, CodingKey {
        case id, name, year, color
        case pantoneValue = "pantone_value"
    }
}
