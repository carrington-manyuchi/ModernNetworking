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
                            size: CGSize(width: 25, height: 25),
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
                                .foregroundColor(.blue)
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

// Add this extension at the bottom of your EmployeesView.swift file
extension EmployeesView {
    func debugPrintEmployees() {
        guard let employees = employeesViewModel.employees?.data else {
            print("❌ No employees data available")
            return
        }
        
        print("✅ Found \(employees.count) employees")
        for employee in employees {
            print("ID: \(employee.id ?? 0)")
            print("Name: \(employee.firstName ?? "nil") \(employee.lastName ?? "nil")")
            print("Email: \(employee.email ?? "nil")")
            print("---")
        }
    }
}

