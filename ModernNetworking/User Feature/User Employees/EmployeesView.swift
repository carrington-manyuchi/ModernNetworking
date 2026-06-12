//
//  EmployeesView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI

struct EmployeesView: View {
    @ObservedObject private var employeesViewModel: EmployeesViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(employeesViewModel: EmployeesViewModel) {
        self.employeesViewModel = employeesViewModel
    }
    
    var body: some View {
        VStack {
            if let employees = employeesViewModel.employees?.data {
                List(employees, id: \.id) { employee in
                    HStack {
                        AsyncImageView(
                            url: employee.avatar,
                            placeholder: Image(systemName: "person.circle.fill"),
                            size: CGSize(width: 50, height: 50),
                            isCircular: true
                        )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(employee.email ?? "No email")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        if employeesViewModel.selectedEmployee?.id == employee.id {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.gray.opacity(0.5))
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.horizontal)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        employeesViewModel.selectEmployee(employee)
                        dismiss()
                    }
                }
            } else if employeesViewModel.isLoading {
                ProgressComponentView(isLoading: $employeesViewModel.isLoading)
            } else {
                Text("No employees found")
                    .foregroundColor(.gray)
            }
        }
        .navigationTitle("List of employees")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            if employeesViewModel.employees == nil {
                await employeesViewModel.fetchEmployees(page: 1)
            }
        }
    }
}

#Preview {
    NavigationStack {
        let networkService = NetworkServiceImplementation()
        let repository = NetworkServiceRepositoryImplementation(networkService: networkService)
        EmployeesView(employeesViewModel: EmployeesViewModel(repository: repository))
    }
}
