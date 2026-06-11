//
//  LoginView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var focusedField: Field?
    
    enum Field {
        case email, password
    }
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                // Error message display
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .font(.caption)
                        .padding(.bottom, 10)
                }
                
                Text("Username")
                    .font(.system(size: 15))
                
                TextField("Enter your username", text: $viewModel.username)
                    .keyboardType(.emailAddress)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .email)
                    .onSubmit {
                        focusedField = .password
                    }
                
                Rectangle()
                    .foregroundStyle(.gray.opacity(0.4))
                    .frame(height: 1)
                    .padding(.bottom, 15)
                
                Text("Password")
                    .font(.system(size: 15))
                
                SecureField("Enter your password", text: $viewModel.password)  // Changed to SecureField
                    .keyboardType(.default)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .focused($focusedField, equals: .password)
                    .onSubmit {
                        Task {
                            await viewModel.login()
                        }
                    }
                
                Rectangle()
                    .foregroundStyle(.gray.opacity(0.4))
                    .frame(height: 1)
                    .padding(.bottom, 15)
                
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
                
                if viewModel.isLoading {
                    ProgressView()
                        .padding()
                }
            }
            .padding(.horizontal)
        }
        .navigationDestination(isPresented: $viewModel.isLoggedIn) {
            ContentView()
                .navigationBarBackButtonHidden(true)
        }
        .alert("Error", isPresented: Binding(
            get: { viewModel.errorMessage != nil },
            set: { if !$0 { viewModel.errorMessage = nil } }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
            }
        }
    }
}

#Preview {
    NavigationStack {
        LoginView()
    }
}
