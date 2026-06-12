//
//  ProgressComponentView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import SwiftUI

struct ProgressComponentView: View {
    @Binding var isLoading: Bool
    
    var body: some View {
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
        .animation(.easeInOut(duration: 0.2), value: isLoading)
    }
}

#Preview {
    ProgressComponentView(isLoading: .constant(true))
}
