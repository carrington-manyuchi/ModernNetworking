//
//  AsyncImageView.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import SwiftUI

// MARK: - AsyncImageView
struct AsyncImageView: View {
    let url: String?
    let placeholder: Image
    var size: CGSize = CGSize(width: 40, height: 40)
    var cornerRadius: CGFloat = 20
    var isCircular: Bool = true
    
    init(url: String?,
         placeholder: Image = Image(systemName: "person.circle.fill"),
         size: CGSize = CGSize(width: 40, height: 40),
         cornerRadius: CGFloat = 20,
         isCircular: Bool = true) {
        self.url = url
        self.placeholder = placeholder
        self.size = size
        self.cornerRadius = cornerRadius
        self.isCircular = isCircular
    }
    
    var body: some View {
        Group {
            if let urlString = url, let imageURL = URL(string: urlString) {
                AsyncImage(url: imageURL) { phase in
                    switch phase {
                    case .empty:
                        loadingView
                    case .success(let image):
                        imageView(image)
                    case .failure:
                        placeholderView
                    @unknown default:
                        placeholderView
                    }
                }
            } else {
                placeholderView
            }
        }
        .frame(width: size.width, height: size.height)
    }
    
    @ViewBuilder
    private var loadingView: some View {
        ProgressView()
            .frame(width: size.width, height: size.height)
    }
    
    @ViewBuilder
    private var placeholderView: some View {
        placeholder
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: size.width, height: size.height)
            .foregroundColor(.gray)
            .applyShape(isCircular: isCircular, cornerRadius: cornerRadius)
    }
    
    @ViewBuilder
    private func imageView(_ image: Image) -> some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: size.width, height: size.height)
            .applyShape(isCircular: isCircular, cornerRadius: cornerRadius)
    }
}

// MARK: - Shape Modifier
extension View {
    @ViewBuilder
    func applyShape(isCircular: Bool, cornerRadius: CGFloat) -> some View {
        if isCircular {
            self.clipShape(Circle())
        } else {
            self.clipShape(RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}

// MARK: - Usage Examples
struct AsyncImageView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            // Circular avatar (default)
            AsyncImageView(url: "https://reqres.in/img/faces/1-image.jpg")
            
            // Large circular avatar
            AsyncImageView(url: "https://reqres.in/img/faces/1-image.jpg",
                          size: CGSize(width: 100, height: 100))
            
            // Square image with custom corner radius
            AsyncImageView(url: "https://reqres.in/img/faces/1-image.jpg",
                          placeholder: Image(systemName: "photo.fill"),
                          size: CGSize(width: 150, height: 150),
                          cornerRadius: 12,
                          isCircular: false)
            
            // With custom placeholder
            AsyncImageView(url: nil,
                          placeholder: Image(systemName: "person.fill"),
                          size: CGSize(width: 60, height: 60))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
