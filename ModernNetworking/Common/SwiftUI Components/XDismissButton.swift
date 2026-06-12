//
//  XDismissButton.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import SwiftUI

struct XDismissButton: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundStyle(.white)
                .opacity(0.6)
            Image(systemName: "xmark")
                .imageScale(.small)
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    XDismissButton()
}
