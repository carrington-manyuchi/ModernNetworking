//
//  RatingsView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import SwiftUI

struct RatingsView: View {
    var rating: Int
    var maxRating = 6
    
    var body: some View {
        VStack {
            HStack {
                ForEach(1...maxRating, id: \.self) { index in
                    Image(systemName: index <= rating  ?  "fork.knife.circle.fill" : "circle")
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    RatingsView(rating: 2)
}
