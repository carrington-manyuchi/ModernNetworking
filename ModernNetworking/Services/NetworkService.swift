//
//  NetworkService.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation

// MARK: - Network Service Protocol
protocol NetworkService {
    func get<U: Decodable>(_ path: String) async throws -> U
    func post<T: Encodable, U: Decodable>(_ request: T, to path: String) async throws -> U
    func put<T: Encodable, U: Decodable>(_ request: T, to path: String) async throws -> U
    func delete<U: Decodable>(_ path: String) async throws -> U
}

// MARK: - Network Service Implementation
final class NetworkServiceImplementation: NetworkService {
    private let baseURL: String
    private let apiKey: String
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder
    
    init(baseURL: String = "https://reqres.in", apiKey: String = "free_user_32Nrdpujz0B5RtrGYKfKiaiLWHi") {
        self.baseURL = baseURL
        self.apiKey = apiKey
        self.session = URLSession.shared
        
        self.decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
        
        self.encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        encoder.dateEncodingStrategy = .iso8601
    }
    
    private var authToken: String?
    
    func setAuthToken(_ token: String) {
        self.authToken = token
    }
    
    // MARK: - Private Helper Methods   cityslicka    eve.holt@reqres.in
    private func addAuthHeaders(to request: inout URLRequest) {
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(apiKey, forHTTPHeaderField: "X-API-Key")
        
        if let token = authToken {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
            
    #if DEBUG
            print("🔑 API Key added to headers: \(apiKey.prefix(10))...")
    #endif
    }
    
    // MARK: - GET Request
    func get<U: Decodable>(_ path: String) async throws -> U {
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        print("📡 GET URL: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        addAuthHeaders(to: &request)
        
        return try await performRequest(request)
    }
    
    // MARK: - POST Request
    func post<T: Encodable, U: Decodable>(_ request: T, to path: String) async throws -> U {
        // FIXED: Removed apiKey from URL - it goes in headers, not URL path!
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        print("📡 POST URL: \(url)")
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        addAuthHeaders(to: &urlRequest)
        urlRequest.httpBody = try encoder.encode(request)
        
#if DEBUG
        if let body = urlRequest.httpBody, let bodyString = String(data: body, encoding: .utf8) {
            print("📡 Request Body: \(bodyString)")
        }
#endif
        
        return try await performRequest(urlRequest)
    }
    
    // MARK: - PUT Request
    func put<T: Encodable, U: Decodable>(_ request: T, to path: String) async throws -> U {
        // FIXED: Removed apiKey from URL - it goes in headers, not URL path!
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "PUT"
        addAuthHeaders(to: &urlRequest)
        urlRequest.httpBody = try encoder.encode(request)
        
        return try await performRequest(urlRequest)
    }
    
    // MARK: - DELETE Request
    func delete<U: Decodable>(_ path: String) async throws -> U {
        // FIXED: Removed apiKey from URL - it goes in headers, not URL path!
        guard let url = URL(string: baseURL + path) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        addAuthHeaders(to: &request)
        
        return try await performRequest(request)
    }
    
    // MARK: - Private Methods
    private func performRequest<T: Decodable>(_ request: URLRequest) async throws -> T {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                throw APIError.unknown("Invalid response type")
            }
            
            print("📡 Status code: \(httpResponse.statusCode)")
            
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
#endif
            
            // Decode the response
            do {
                return try decoder.decode(T.self, from: data)
            } catch {
                print("❌ Decoding error: \(error)")
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("❌ Raw response: \(jsonString)")
                }
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
