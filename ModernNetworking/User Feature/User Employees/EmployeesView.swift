//
//  EmployeesView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI
import SwiftUI

struct EmployeesView: View {
    @StateObject private var employeesViewModel = EmployeesViewModel()
    
    var body: some View {
        VStack {
            if let employees = employeesViewModel.employees?.data {
                let _ = print("📊 Number of employees: \(employees.count)")
                if let firstEmployee = employees.first {
                                    let _ = print("👤 First employee - Name: \(firstEmployee.firstName ?? "nil") \(firstEmployee.lastName ?? "nil")")
                                    let _ = print("📧 First employee - Email: \(firstEmployee.email ?? "nil")")
                                    let _ = print("🖼️ First employee - Avatar: \(firstEmployee.avatar ?? "nil")")
                                }

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
                            
                            Text(employee.email ?? "")
                                .font(.system(size: 12))
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal)
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
            await employeesViewModel.fetchEmployees(page: 1)
        }
    }
}

#Preview {
    NavigationStack {
        EmployeesView()
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

