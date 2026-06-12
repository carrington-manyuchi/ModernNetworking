//
//  ActivityIndicator.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import SwiftUI


struct ActivityIndicator: UIViewRepresentable {
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.color = UIColor(named: "brandPrimary")
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        
    }
}


struct LoadingView: View {
    var body: some View {
        ZStack {
            ActivityIndicator()
        }
    }
}


#Preview {
    LoadingView()
}
