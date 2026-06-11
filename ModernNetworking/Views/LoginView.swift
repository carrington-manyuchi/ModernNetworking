//
//  LoginView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import SwiftUI

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var presentAlert = false
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Username")
                    .font(.system(size: 15))
                
                TextField("Enter your username", text: $email)
                    .keyboardType(.emailAddress)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
                
                Rectangle()
                    .foregroundStyle(.gray.opacity(0.4))
                    .frame(height: 1)
                    .padding(.bottom, 15)
                
                
                Text("Password")
                    .font(.system(size: 15))
                
                TextField("Enter your password", text: $password)
                    .keyboardType(.default)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
                
                Rectangle()
                    .foregroundStyle(.gray.opacity(0.4))
                    .frame(height: 1)
                    .padding(.bottom, 15)
                
                
                Button {
                    
                } label: {
                    Text("Login")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(.green)
                        .frame(maxWidth: .infinity)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                }
                
                
                
                
                
            }
            .padding(.horizontal)
        }
        .alert("Error", isPresented: $presentAlert) {
            
        } message: {
            
        }

    }
}

#Preview {
    LoginView()
}

