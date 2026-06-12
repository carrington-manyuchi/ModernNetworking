//
//  EmployeesView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI

struct EmployeesView: View {
    @ObservedObject var dashboardViewModel: DashboardViewModel
    @StateObject private var employeesViewModel: EmployeesViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(dashboardViewModel: DashboardViewModel) {
        self.dashboardViewModel = dashboardViewModel
        self._employeesViewModel = StateObject(wrappedValue: EmployeesViewModel(dashboardViewModel: dashboardViewModel))
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
                            Text("\(employee.firstName ?? "") \(employee.lastName ?? "")")
                                .font(.system(size: 16, weight: .medium))
                            Text(employee.email ?? "No email")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                        
                        if dashboardViewModel.selectedEmployee?.id == employee.id {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 20))
                        }
                    }
                    .padding(.horizontal)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        dashboardViewModel.selectEmployee(employee)
                        dismiss()
                    }
                }
            } else if employeesViewModel.isLoading {
                ProgressView()
                    .scaleEffect(1.5)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
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
