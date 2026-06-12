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
        private let dashboardViewModel: DashboardViewModel?
        
        init(dashboardViewModel: DashboardViewModel? = nil, repository: NetworkServiceRepository? = nil) {
            self.dashboardViewModel = dashboardViewModel
            
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
            
            do {
                let response = try await repository.fetchEmployees(page: page)
                self.employees = response
                self.isLoading = false
            } catch {
                self.isLoading = false
                print("❌ Failed to fetch employees: \(error)")
            }
        }
        
        func selectEmployee(_ employee: Employee) {
            dashboardViewModel?.selectEmployee(employee)
        }
    }
