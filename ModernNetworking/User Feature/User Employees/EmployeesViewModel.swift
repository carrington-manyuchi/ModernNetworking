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
        
        print("🔄 Fetching employees for page: \(page)")

        do {
            let response = try await repository.fetchEmployees(page: page)
            self.employees = response
            
           
            
            // Log the response details
            print("✅ Successfully fetched employees")
            print("📊 Page: \(response.page ?? 0)/\(response.totalPages ?? 0)")
            print("📊 Total employees: \(response.total ?? 0)")
            print("📊 Employees on this page: \(response.data?.count ?? 0)")
            
            // Log each employee
                        if let employees = response.data {
                            for (index, employee) in employees.enumerated() {
                                print("👤 Employee \(index + 1):")
                                print("   - ID: \(employee.id ?? 0)")
                                print("   - Name: \(employee.firstName ?? "") \(employee.lastName ?? "")")
                                print("   - Email: \(employee.email ?? "")")
                                print("   - Avatar: \(employee.avatar ?? "")")
                            }
                        }
                        
                        // Log support info
                        if let support = response.support {
                            print("📧 Support URL: \(support.url ?? "")")
                            print("📧 Support Text: \(support.text ?? "")")
                        }
            self.isLoading = false

        } catch {
            self.errorMessage = error.localizedDescription
            self.isLoading = false
            print("Failed to fetch employees: \(error)")
            
            print("❌ Failed to fetch employees: \(error)")
            print("❌ Error details: \(error.localizedDescription)")
        }
    }
    
}
