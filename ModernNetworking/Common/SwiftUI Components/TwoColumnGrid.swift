//
//  TwoColumnGrid.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//


import Foundation
import SwiftUI


struct TwoColumnGrid<Content: View>: View {
    @ViewBuilder var content: () -> Content

    let columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body:  some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                content()
            }
        }
    }
}
