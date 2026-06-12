//
//  DashboardView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import SwiftUI

struct DashboardView: View {
    @StateObject private var viewModel = DashboardViewModel()
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
                    if let selectedEmployee = viewModel.selectedEmployee,
                       let avatarURL = selectedEmployee.avatar {
                        AsyncImageView(
                            url: avatarURL,
                            placeholder: Image(systemName: "person.circle.fill"),
                            size: CGSize(width: 50, height: 50),
                            isCircular: true
                        )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("\(selectedEmployee.firstName ?? "") \(selectedEmployee.lastName ?? "")")
                                .font(.system(size: 14, weight: .medium))
                            Text("Selected")
                                .font(.system(size: 10))
                                .foregroundColor(.green)
                        }
                        .padding(.leading, 8)
                    } else if let firstEmployee = viewModel.employees?.data?.first,
                              let avatarURL = firstEmployee.avatar {
                        AsyncImageView(
                            url: avatarURL,
                            placeholder: Image(systemName: "person.circle.fill"),
                            size: CGSize(width: 50, height: 50),
                            isCircular: true
                        )
                    } else if viewModel.isLoading {
                        ProgressView()
                            .frame(width: 50, height: 50)
                    } else {
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
                EmployeesView(dashboardViewModel: viewModel)
            }
            
            VStack(spacing: 30) {
                DatePicker("D.O.B", selection: Binding(
                    get: { viewModel.userData.dateOfBirth },
                    set: { viewModel.updateDateOfBirth($0) }
                ), displayedComponents: [.date])
                
                VStack(alignment: .leading) {
                    Text("Place of birth")
                        .font(.system(size: 15))
                    
                    TextField("Enter place of birth", text: Binding(
                        get: { viewModel.userData.placeOfBirth },
                        set: { viewModel.updatePlaceOfBirth($0) }
                    ))
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
                    .foregroundStyle(.black)
                    .overlay(alignment: .trailing) {
                        if !viewModel.userData.placeOfBirth.isEmpty {
                            Button {
                                viewModel.updatePlaceOfBirth("")
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
            
            // Next Button
            Button {
                viewModel.navigateToAdditionalInfo = true
            } label: {
                Text("Next")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(SwiftUI.Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.bottom, 30)
            .disabled(viewModel.selectedEmployee == nil)
            .opacity(viewModel.selectedEmployee == nil ? 0.5 : 1)
        }
        .navigationTitle("Employee")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $viewModel.navigateToAdditionalInfo) {
            AdditionalInformationView(viewModel: AdditionalInformationViewModel(userData: viewModel.userData))
        }
        .task {
            await viewModel.fetchEmployees(page: 1)
        }
    }
}

#Preview {
    NavigationStack {
        DashboardView()
    }
}
