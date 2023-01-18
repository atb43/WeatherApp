//
//  ImageCache.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

enum ImageCacheError: Error {
    case failedInsert
}

protocol ImageCache {
    func get(for url: URL) -> Data?
    func insert(for url: URL, data: any AnyObject) throws
}

final class ImageURLCache: ImageCache {
    private let urlCache: URLCache = {
        let cachesURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
        let diskCacheURL = cachesURL.appendingPathComponent(Constants.ImageCache.name)
        let cache = URLCache(memoryCapacity: Constants.ImageCache.memoryCapacity,
                             diskCapacity: Constants.ImageCache.diskCapacity,
                             directory: diskCacheURL)
        return cache
    }()
    
    func get(for url: URL) -> Data? {
        guard let cachedData = urlCache.cachedResponse(for: URLRequest(url: url)) else {
            return nil
        }
        return cachedData.data
    }
    
    func insert(for url: URL, data: any AnyObject) throws {
        guard let cacheData = data as? CachedURLResponse else {
            throw ImageCacheError.failedInsert
        }
        urlCache.storeCachedResponse(cacheData, for: URLRequest(url: url))
    }
}
