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
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(viewModel.isFormValid ? .green : .gray)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(!viewModel.isFormValid || viewModel.isLoading)

            }
            .padding(.horizontal)
            
                if viewModel.isLoading {
                    ZStack {
                        ProgressView()
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .scaleEffect(1.5)
                            .tint(.white)
                    }
                    .transition(.opacity)
                    .ignoresSafeArea()
                    .background(.black.opacity(0.4))
                    .animation(.easeInOut(duration: 0.2), value: viewModel.isLoading)
                }
        }
        .ignoresSafeArea()
        .navigationDestination(isPresented: $viewModel.isLoggedIn) {
            ContentView()
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
