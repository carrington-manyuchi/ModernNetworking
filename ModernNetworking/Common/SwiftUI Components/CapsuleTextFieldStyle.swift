//
//  File.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/14.
//

import Foundation
import SwiftUI

struct CapsuleTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .background(
                Capsule()
                    .fill(.gray)
            )
    }
}
