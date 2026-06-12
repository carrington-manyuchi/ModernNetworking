//
//  DashboardView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var employeesViewModel = EmployeesViewModel()
    @State private var date = Date()
    @State private var placeOfBirth: String = ""
    @State private var navigateToEmployeesList = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Spacer()
            Text("Select an employee")
                .font(.system(size: 16, weight: .semibold))
                .padding(.horizontal)
            
            Group {
                Divider()
                HStack {
                    if let selectedEmployee = employeesViewModel.selectedEmployee,
                       let avatarURL = selectedEmployee.avatar {
                        AsyncImageView(
                            url: avatarURL,
                            placeholder: Image(systemName: "person.circle.fills"),
                            size: CGSize(width: 50, height: 50),
                            isCircular: true
                        )
                        
                    } else if let firstEmployee = employeesViewModel.employees?.data?.first,
                              let avatarURL = firstEmployee.avatar {
                        AsyncImageView(
                            url: avatarURL,
                            placeholder: Image(systemName: "person.circle.fill"),
                            size: CGSize(width: 50, height: 50),
                            isCircular: true
                        )
                        
                    } else if employeesViewModel.isLoading {
                        ProgressComponentView(isLoading: $employeesViewModel.isLoading)
                    }  else {
                        Image(systemName: "person.circle.fill")
                            .padding(.vertical, 5)
                            .font(.largeTitle)
                    }
                    
                    Spacer()
                    Image(systemName: "chevron.forward")
                        .font(.title3)
                }
                .contentShape(Rectangle())
                .padding(.horizontal)
                .padding(.vertical, 2)
                .onTapGesture {
                    navigateToEmployeesList = true
                }
                Divider()
            }
            .navigationDestination(isPresented: $navigateToEmployeesList) {
                EmployeesView(employeesViewModel: employeesViewModel)
            }
            
            VStack( spacing: 30) {
                DatePicker("D.O.B", selection: $date, displayedComponents: [.date])
                
                VStack(alignment: .leading) {
                    Text("Place of birth")
                        .font(.system(size: 15))
                    
                    TextField("Enter place of birth", text: $placeOfBirth)
                        .font(.system(size: 14))
                        .textInputAutocapitalization(.never)
                        .foregroundStyle(.black)
                        .overlay(alignment: .trailing) {
                            if !placeOfBirth.isEmpty {
                                Button {
                                    placeOfBirth = ""
                                } label: {
                                    Image(systemName: "xmark.circle.fill")
                                        .padding(.trailing,8)
                                        .foregroundStyle(.black.opacity(0.3))
                                }
                            }
                        }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundStyle(.black.opacity(0.2))
                }
            }
            .padding(.top, 50)
            .padding(.horizontal)
            Spacer()
            Spacer()
        }
        .navigationTitle("Employee")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await employeesViewModel.fetchEmployees(page: 1)
        }
    }
}

#Preview {
    NavigationStack {
        DashboardView()
    }
}
