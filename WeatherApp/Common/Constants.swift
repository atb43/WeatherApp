//
//  Constants.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

struct Constants {
    struct WeatherAPI {
        // Note: set APP ID manually before running.
        // Must handle APP ID more securely in production code.
        // For instance, key encryption or fetching through REST API
        static let appID = ""
        
        static let baseURL = "https://api.openweathermap.org/data/2.5"
        static let baseImageURL = "https://openweathermap.org/img/wn"
    }
    
    struct ImageCache {
        static let name = "DownloadCache"
        static let memoryCapacity = 1_000_000 // ~1 MB
        static let diskCapacity = 10_000_000 // ~10 MB
    }
}

struct AppMessages {
    static let ok = "OK"
    static let error = "Error"
    static let failedFeatchWeather = "Failed to fetch weather!"
}
