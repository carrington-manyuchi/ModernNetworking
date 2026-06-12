//
//  EmployeesViewModel.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import SwiftUI
import Combine

final class EmployeesViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isLoggedIn = false
    @Published var errorMessage = ""
    @Published var employees: Employees?
    @Published var selectedEmployee: Employee?
    
    private let repository: NetworkServiceRepository
    
    init(repository: NetworkServiceRepository? = nil) {
        if let repository = repository {
            self.repository = repository
        } else {
            let networkService = NetworkServiceImplementation()
            self.repository = NetworkServiceRepositoryImplementation(networkService: networkService)
        }
    }
    
    
    @MainActor
    func fetchEmployees(page: Int = 1) async {
        isLoading = true
        errorMessage = ""

        do {
            let response = try await repository.fetchEmployees(page: page)
            self.employees = response
            self.isLoading = false

        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
         
        }
    }
    
}
