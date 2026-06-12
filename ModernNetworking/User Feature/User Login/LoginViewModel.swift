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
    @Published var username = ""
    @Published var password: String = ""
    @Published var presentAlert: Bool = false
    @Published var showPassword: Bool = false
    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var errorMessage = ""
    
    private let repository: NetworkServiceRepository
    
    init(repository: NetworkServiceRepository? = nil) {
        if let repository = repository {
            self.repository = repository
        } else {
            let networkService = NetworkServiceImplementation()
            self.repository = NetworkServiceRepositoryImplementation(networkService: networkService)
        }
    }
        
    var isFormValid: Bool {
        !username.trimmingCharacters(in: .whitespaces).isEmpty &&
        password.count >= 4 && !isLoading
    }
    
    func login() async {
        isLoading = true
        presentAlert = false
        errorMessage = ""
        
        guard validateInput() else {
            isLoading = false
            presentAlert  = true
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
            presentAlert = true
            print(errorMessage)
        }
        isLoading = false
    }
    
    func resetForm() {
        username = ""
        password = ""
        errorMessage = ""
        presentAlert = false
    }
    
    private func validateInput() -> Bool {
        if username.trimmingCharacters(in: .whitespaces).isEmpty {
            errorMessage = "Username is required"
            print(errorMessage)
            return false
        }
        
        if password.isEmpty {
            errorMessage = "Password is required"
            print(errorMessage)
            return false
        }
        
        if password.count < 4 {
            errorMessage = "Password must be at least 4 characters"
            print(errorMessage)
            return false
        }
        
        return true
    }
    
    private func handleSuccessfulLogin(token: String) async {
        UserDefaults.standard.set(token, forKey: "authToken")
        if let networkService = (repository as? NetworkServiceRepositoryImplementation)?.networkService as? NetworkServiceImplementation {
            networkService.setAuthToken(token)
        }
        isLoggedIn = true
        presentAlert = false
    }
}
