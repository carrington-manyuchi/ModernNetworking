//
//  ProductDetailedDescription.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import SwiftUI


struct ProductDetailedDescription: View {
    @State private var isExapanded = true

    var body: some View {
        HStack {
            DisclosureGroup(isExpanded: $isExapanded) {
                Text("Apples Are Nutritious. Apples May Be Good For Weight Loss. Apples May Be Good For Your Heart. As Part Of A Healthful And Varied Diet. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam auctor quam id massa faucibus dignissim.")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fontWeight(.light)
            } label: {
                Text("Product Detail")
                    .font(.headline)
                    .foregroundStyle(.black)
            }
            .tint(.secondary)
        }
        
        Divider()
            .padding(7)
    }
}


#Preview {
    ProductDetailedDescription()
}
