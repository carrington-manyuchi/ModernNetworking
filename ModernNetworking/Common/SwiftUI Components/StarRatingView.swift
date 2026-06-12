//
//  StarRatingView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import SwiftUI

struct StarRatingView: View {
    let rating: Double

    
    var body: some View {
        HStack(spacing: 2) {
            Image(systemName: "star.fill")
            Text("\(rating, specifier: "%.1f")")

        }
        .foregroundStyle(.black)
    }
}

#Preview {
    StarRatingView(rating: 4.5)
}
