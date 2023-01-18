//
//  ImageRepositoryImp.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

final class ImageRepository: ImageRepositoryIntf {
    private let imageCache: ImageCache
    
    init(imageCache: ImageCache = ImageURLCache()) {
        self.imageCache = imageCache
    }
    
    func getImage(for url: URL) async -> Data? {
        if let cached = imageCache.get(for: url) {
            return cached
        } else {
            do {
                let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
                let cacheResponse = CachedURLResponse(response: response, data: data)
                try imageCache.insert(for: url, data: cacheResponse)
                return imageCache.get(for: url)
            } catch {
                return nil
            }
        }
        
    }
}
