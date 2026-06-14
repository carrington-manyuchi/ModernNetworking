//
//  LoadingComponentView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/14.
//

import Foundation
import SwiftUI

struct LoadingComponentView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
            ProgressView()
                .tint(.white)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    LoadingComponentView()
}
