//
//  PrimaryButtonStyle.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/11.
//

import Foundation
import SwiftUI


struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .aligned(.center)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(.white)
            .padding(12)
            .background(.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
