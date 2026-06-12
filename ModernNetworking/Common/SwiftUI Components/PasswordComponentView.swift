//
//  PasswordComponentView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import SwiftUI

struct PasswordComponentView: View {
    @Binding var showPassword: Bool
    @Binding var password: String
    
    var body: some View {
        if showPassword {
            TextField("Enter your password", text: $password)
                .textFieldStyle(AuthTextFieldStyle())
                .overlay(alignment: .trailing) {
                    Button {
                        showPassword = false
                    } label: {
                        Image(systemName: "eye")
                            .foregroundStyle(.black)
                    }
                    .padding(.bottom, 15)
                }
        } else {
            SecureField("Enter your password", text: $password)
                .textFieldStyle(AuthTextFieldStyle())
                .overlay(alignment: .trailing) {
                    Button {
                        showPassword = true
                    } label: {
                        Image(systemName: "eye.slash")
                            .foregroundStyle(.black)
                    }
                    .padding(.bottom, 15)
                }
        }
    }
}


#Preview {
    PasswordComponentView(
        showPassword: .constant(true),
        password: .constant("")
    )
}
