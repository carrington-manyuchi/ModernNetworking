//
//  UserColor.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation

// MARK: - UserColor
struct UserColor: Codable {
    let page: Int
    let perPage: Int
    let total: Int
    let totalPages: Int
    let data: [ColorResponse]
    let support: Support?
//    
//    enum CodingKeys: String, CodingKey {
//        case page
//        case perPage = "per_page"
//        case total
//        case totalPages = "total_pages"
//        case data
//        case support
//    }
//    
//    // Custom init to handle any extra fields gracefully
//    init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        
//        page = try container.decode(Int.self, forKey: .page)
//        perPage = try container.decode(Int.self, forKey: .perPage)
//        total = try container.decode(Int.self, forKey: .total)
//        totalPages = try container.decode(Int.self, forKey: .totalPages)
//        data = try container.decode([ColorResponse].self, forKey: .data)
//        support = try? container.decode(Support.self, forKey: .support) // Optional
//    }
//    
//    // Standard encode
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//        try container.encode(page, forKey: .page)
//        try container.encode(perPage, forKey: .perPage)
//        try container.encode(total, forKey: .total)
//        try container.encode(totalPages, forKey: .totalPages)
//        try container.encode(data, forKey: .data)
//        try container.encode(support, forKey: .support)
//    }
}

// MARK: - ColorResponse
struct ColorResponse: Codable, Identifiable {
    let id: Int
    let name: String
    let year: Int
    let color: String
    let pantoneValue: String
//    
//    enum CodingKeys: String, CodingKey {
//        case id, name, year, color
//        case pantoneValue = "pantone_value"
//    }
}
