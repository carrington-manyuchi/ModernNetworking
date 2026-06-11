//
//  AuthTextFieldStyle.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import SwiftUI

struct AuthTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack {
            configuration
                .font(.system(size: 14))
                .textInputAutocapitalization(.never)
            
            Rectangle()
                .foregroundStyle(.black.opacity(0.2))
                .frame(height: 1)
                .padding(.bottom, 15)
        }
    }
}
