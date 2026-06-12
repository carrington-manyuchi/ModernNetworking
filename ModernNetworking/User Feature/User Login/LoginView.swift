//
//  LoginView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//    Development - Delivery
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.system(size: 15))
                
                TextField("Enter your username", text: $viewModel.username)
                    .keyboardType(.emailAddress)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .disabled(viewModel.isLoading)
                
                Rectangle()
                    .foregroundStyle(.gray.opacity(0.4))
                    .frame(height: 1)
                    .padding(.bottom, 15)
                
                Text("Password")
                    .font(.system(size: 15))
                
                PasswordComponentView(showPassword: $viewModel.showPassword, password: $viewModel.password)
                
                Button {
                    Task {
                        await viewModel.login()
                    }
                } label: {
                    Text("Login")
                }
                .buttonStyle(PrimaryButtonStyle())
                .disabled(!viewModel.isFormValid || viewModel.isLoading)
            }
            .padding(.horizontal)
            
            if viewModel.isLoading {
                ProgressComponentView(isLoading: $viewModel.isLoading)
            }
        }
        .ignoresSafeArea()
        .navigationDestination(isPresented: $viewModel.isLoggedIn) {
            DashboardView()
                .navigationBarBackButtonHidden(true)
        }
        .alert("Error", isPresented: $viewModel.presentAlert) {
            
        } message: {
            Text(viewModel.errorMessage)
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
