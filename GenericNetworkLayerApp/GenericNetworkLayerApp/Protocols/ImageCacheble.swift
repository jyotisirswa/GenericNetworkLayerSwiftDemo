//
//  ImageCacheble.swift
//  GenericNetworkLayerApp
//
//  Created by Jyoti - LetsWork on 1/13/24.
//

import Foundation
import UIKit
//1 Create the protocol
protocol ImageCacheble{}

//2 Creating a imageCache private property
private let imageCache =  NSCache<NSString, UIImage>()

//3
extension UIImageView : ImageCacheble {}

//4 creating a protocol extension to add optional function implementations
extension ImageCacheble where Self : UIImageView {
    @MainActor
    func loadImageUsingCacheWithURLStringTwo(_ urlString: String, placeHolder: UIImage?) async throws {
        let cacheKey = NSString(string: urlString)
        if let cachedImage = imageCache.object(forKey: cacheKey) {
            self.image = cachedImage
        }
        guard let url = URL(string: urlString) else {
            self.image = placeHolder
            throw APIError.invalidURLError(description: "\(urlString)")
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else {
                self.image = placeHolder
                throw APIError.invalidData
            }
            imageCache.setObject(image, forKey: cacheKey)
            self.image = image
        } catch {
            print("Convert Image from data Error : \(error.localizedDescription)")
            throw APIError.imageLoadingError(description: error.localizedDescription)
        }
    }
}


