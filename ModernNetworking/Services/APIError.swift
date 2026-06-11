//
//  APIError.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation


// MARK: - API Errors
enum APIError: LocalizedError {
    case invalidURL
    case noInternet
    case timeout
    case unauthorized
    case resourceNotFound
    case serverError(Int)
    case decodingFailed
    case unknown(String)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noInternet:
            return "No internet connection"
        case .timeout:
            return "Request timed out"
        case .unauthorized:
            return "Unauthorized access"
        case .resourceNotFound:
            return "Resource not found"
        case .serverError(let code):
            return "Server error: \(code)"
        case .decodingFailed:
            return "Failed to decode response"
        case .unknown(let message):
            return "An error occurred: \(message)"
        }
    }
}
