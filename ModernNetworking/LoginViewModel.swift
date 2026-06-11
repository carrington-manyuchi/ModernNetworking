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
    @Published var username = ""  // Added @Published
    @Published var password = ""  // Added @Published
    @Published var presentAlert = false
    
    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var errorMessage: String?
    
    // MARK: - Dependencies
    private let repository: NetworkServiceRepository
    
    // MARK: - Initialization
    init(repository: NetworkServiceRepository? = nil) {
        if let repository = repository {
            self.repository = repository
        } else {
            let networkService = NetworkServiceImplementation()
            self.repository = NetworkServiceRepositoryImplementation(networkService: networkService)
        }
    }
    
    
    // MARK: - Computed Properties
    var isFormValid: Bool {
        !username.trimmingCharacters(in: .whitespaces).isEmpty &&
        password.count >= 4 &&  // Changed to match validation (4 characters)
        !isLoading
    }
    
    // MARK: - Public Methods
    func login() async {
        // Reset states
        errorMessage = nil
        isLoading = true
        
        // Validate before making network call
        guard validateInput() else {
            isLoading = false
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
            print(errorMessage!)
        }
        
        isLoading = false
    }
    
    func resetForm() {
        username = ""
        password = ""
        errorMessage = nil
        // Don't reset isLoading and isLoggedIn here - they're controlled elsewhere
    }
    
    // MARK: - Private Methods
    private func validateInput() -> Bool {
        if username.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Username is required"
            print(errorMessage!)
            return false
        }
        
        if password.isEmpty {
            errorMessage = "Password is required"
            print(errorMessage!)
            return false
        }
        
        if password.count < 4 {
            errorMessage = "Password must be at least 4 characters"  // Changed to match validation
            print(errorMessage!)
            return false
        }
        
        return true
    }
    
    private func handleSuccessfulLogin(token: String) async {
        // Save token (use Keychain in production)
        UserDefaults.standard.set(token, forKey: "authToken")
        // Set token in network service for future requests
        if let networkService = (repository as? NetworkServiceRepositoryImplementation)?.networkService as? NetworkServiceImplementation {
            networkService.setAuthToken(token)
        }
        isLoggedIn = true
    }
}
