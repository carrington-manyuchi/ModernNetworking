//
//  DashboardViewModel.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import Combine
import SwiftUI

final class DashboardViewModel: ObservableObject {
    @Published var userData = UserData()
    @Published var isLoading = false
    @Published var employees: Employees?
    @Published var selectedEmployee: Employee?
    @Published var navigateToAdditionalInfo = false
    
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
        self.selectedEmployee = employee
        self.userData.selectedEmployee = employee
    }
    
    func updateDateOfBirth(_ date: Date) {
        userData.dateOfBirth = date
    }
    
    func updatePlaceOfBirth(_ place: String) {
        userData.placeOfBirth = place
    }
}
