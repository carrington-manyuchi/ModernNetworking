//
//  NetworkService.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation


// MARK: - For different base url?
enum NetworkServiceEndpoint {
    case auth(String)
    case users(String)
    case payments(String)
    case analytics(String)
    
    var baseURL: String {
        switch self {
        case .auth: return "https://auth.myapp.com"
        case .users: return "https://users.myapp.com"
        case .payments: return "https://payment.myapp.com"
        case .analytics: return "https://analytics.myapp.com"
        }
    }
    
    var fullURL: String {
        switch self {
        case .auth(let path): return baseURL + path
        case .users(let path): return baseURL + path
        case .payments(let path): return baseURL + path
        case .analytics(let path): return baseURL + path
        }
    }
}


// MARK: - APIService Protocol

protocol NetworkService {
    func get<U: Decodable>(_ path: String) async throws -> U
    func post<T: Encodable, U: Decodable>(_ request: T, to path: String) async throws -> U
    func put<T: Encodable, U: Decodable>(_ request: T, to path: String) async throws -> U
    func delete<U: Decodable>(_ path: String) async throws -> U
    
}


// MARK: - APIService Implementation
actor NetworkServiceImplementation: NetworkService {
    private let baseURL: String
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(baseURL: String = "https://reqres.in") {
        self.baseURL = baseURL
        self.session = URLSession.shared
        
        self.decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        self.encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
    }
    
    // MARK: - GET Request
    func get<U: Decodable>(_ path: String) async throws -> U {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return try await performRequest(request)
    }
    
    // MARK: - POST Request with Encodable body
    func post<T: Encodable, U: Decodable>(_ request: T, to path: String) async throws -> U {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try encoder.encode(request)
        
        return try await performRequest(urlRequest)
    }
    
    // MARK: - PUT Request with Encodable body
    func put<T: Encodable, U: Decodable>(_ request: T, to path: String) async throws -> U {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpBody = try encoder.encode(request)
        
        return try await performRequest(urlRequest)
    }
    
    // MARK: - DELETE Request
    func delete<U: Decodable>(_ path: String) async throws -> U {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        return try await performRequest(request)
    }
    
    // MARK: - Private Methods
    private func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknown("Invalid response type")
            }
            
            switch httpResponse.statusCode {
            case 200...299:
                break
            case 401:
                throw APIError.unauthorized
            case 404:
                throw APIError.resourceNotFound
            case 500...599:
                throw APIError.serverError(httpResponse.statusCode)
            default:
                throw APIError.serverError(httpResponse.statusCode)
            }
            
            // Debug: Print response for troubleshooting
            #if DEBUG
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📡 Response for \(request.url?.path ?? "unknown"):")
                print(jsonString)
            }
            #endif // DEBUG
            
            // Decode the response
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                print("❌ Decoding error: \(error)")
                throw APIError.decodingFailed
            }
            
        } catch let error as APIError {
            throw error
        } catch let urlError as URLError {
            switch urlError.code {
            case .notConnectedToInternet, .networkConnectionLost:
                throw APIError.noInternet
            case .timedOut:
                throw APIError.timeout
            default:
                throw APIError.unknown(urlError.localizedDescription)
            }
        } catch {
            throw APIError.unknown(error.localizedDescription)
        }
    }
}

