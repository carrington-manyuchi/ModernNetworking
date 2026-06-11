//
//  LoginViewModel.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class LoginViewModel: ObservableObject {
    
    // MARK: - Published Properties (UI State)
    @Published var username = ""
    @Published var password = ""
    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
    private let repository: NetworkServiceRepository
    
    // MARK: - Initialization
    init(repository: NetworkServiceRepository = NetworkServiceRepositoryImplementation.self as! NetworkServiceRepository) {
        self.repository = repository
    }
    
    // MARK: - Computed Properties
    var isFormValid: Bool {
        !username.trimmingCharacters(in: .whitespaces).isEmpty &&
        password.count >= 6 &&
        !isLoading
    }
    
    func login() async {
        isLoading = true
        errorMessage = nil
        
        guard validateInput() else {
            return
        }
        
        do {
            let loginResponse = try await repository.login(
                username: username.trimmingCharacters(in: .whitespaces),
                password: password
            )
            await handleSuccessfulLogin(token: loginResponse.token)
            
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func resetForm() {
        username = ""
        password = ""
        errorMessage = nil
        isLoading = false
        isLoggedIn = false
    }
    
    private func validateInput() -> Bool {
        if username.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "username is required"
            return false
        }

        if password.isEmpty {
            errorMessage = "Password is required"
            return false
        }
        
        if password.count < 4 {
            errorMessage = "Password must be at least 6 characters"
            return false
        }
        
        return true
    }
    
    private func handleSuccessfulLogin(token: String) async {
        UserDefaults.standard.set(token, forKey: "authToken")
        isLoggedIn = true
        resetForm()
    }
}
