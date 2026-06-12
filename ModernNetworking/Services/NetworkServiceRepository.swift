//
//  NetworkServiceRepository.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation
// MARK: - Service Protocol

protocol NetworkServiceRepository {
    func login(username: String, password: String) async throws -> Login
    func fetchEmployees(page: Int) async throws -> Employees
    func fetchColors() async throws -> UserColor
    func updateUser(userId: Int, firstName: String, lastName: String, email: String) async throws -> Employee
}

final class NetworkServiceRepositoryImplementation: NetworkServiceRepository {
    let networkService: NetworkService
    
    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func login(username: String, password: String) async throws -> Login {
        let request = LoginRequest(username: username, password: password)
        return try await networkService.post(request, to: "/api/login")
    }
    
    func fetchEmployees(page: Int) async throws -> Employees {
        return try await networkService.get("/api/users?page=\(page)")
    }
    
    func fetchColors() async throws -> UserColor {
        let result: UserColor = try await networkService.get("/api/unknown?per_page=12")
        print("✅ Successfully decoded \(result.data.count) colors")
        return result

    }
    
    func updateUser(userId: Int, firstName: String, lastName: String, email: String) async throws -> Employee {
        let request = UpdateUserRequest(firstName: firstName, lastName: lastName, email: email)
        return try await networkService.put(request, to: "/api/users/\(userId)")
    }
}
