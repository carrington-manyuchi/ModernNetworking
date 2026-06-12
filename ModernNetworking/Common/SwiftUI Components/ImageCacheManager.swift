//
//  ImageCacheManager.swift
//  ModernNetworking
//
//  Created by Manyuchi, Carrington C on 2026/06/12.
//

import Foundation
import SwiftUI

// MARK: - Image Cache
class ImageCacheManager {
    static let shared = ImageCacheManager()
    private init() {}
    
    private let cache = NSCache<NSString, UIImage>()
    
    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}

// MARK: - Cached Async Image
struct CachedAsyncImageView: View {
    let url: String?
    let placeholder: Image
    var size: CGSize = CGSize(width: 40, height: 40)
    var isCircular: Bool = true
    var cornerRadius: CGFloat = 20
    
    @State private var image: UIImage?
    @State private var isLoading = false
    
    init(url: String?,
         placeholder: Image = Image(systemName: "person.circle.fill"),
         size: CGSize = CGSize(width: 40, height: 40),
         isCircular: Bool = true,
         cornerRadius: CGFloat = 20) {
        self.url = url
        self.placeholder = placeholder
        self.size = size
        self.isCircular = isCircular
        self.cornerRadius = cornerRadius
    }
    
    var body: some View {
        Group {
            if let image = image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size.width, height: size.height)
                    .applyShape(isCircular: isCircular, cornerRadius: cornerRadius)
            } else if isLoading {
                ProgressView()
                    .frame(width: size.width, height: size.height)
            } else {
                placeholder
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: size.width, height: size.height)
                    .foregroundColor(.gray)
                    .applyShape(isCircular: isCircular, cornerRadius: cornerRadius)
                    .onAppear {
                        loadImage()
                    }
            }
        }
    }
    
    private func loadImage() {
        guard let urlString = url, let imageURL = URL(string: urlString) else { return }
        
        // Check cache first
        if let cachedImage = ImageCacheManager.shared.getImage(forKey: urlString) {
            self.image = cachedImage
            return
        }
        
        isLoading = true
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in
            DispatchQueue.main.async {
                isLoading = false
                if let data = data, let downloadedImage = UIImage(data: data) {
                    ImageCacheManager.shared.setImage(downloadedImage, forKey: urlString)
                    self.image = downloadedImage
                }
            }
        }.resume()
    }
}
