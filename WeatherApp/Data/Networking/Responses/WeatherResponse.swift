//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

struct WeatherResponse: Codable {
    struct Coordinate: Codable {
        let lon: Double
        let lat: Double
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let icon: String
    }
    
    struct Temperature: Codable {
        let temp: Double
        let tempMin: Double
        let tempMax: Double
        let humidity: Int
    }
    
    struct Wind: Codable {
        let speed: Double
    }
    
    struct Sun: Codable {
        let sunrise: Double
        let sunset: Double
    }
    
    let coord: Coordinate
    let weather: [Weather]
    let main: Temperature
    let sys: Sun
    let wind: Wind
    let name: String
}

extension WeatherResponse {
    static var empty: Self {
        WeatherResponse(coord: Coordinate(lon: 0, lat: 0),
                        weather: [Weather(id: 1, main: "Sunny", icon: "10d")],
                        main: Temperature(temp: 0,
                                          tempMin: 0.0,
                                          tempMax: 0.0,
                                          humidity: 0),
                        sys: Sun(sunrise: Date().timeIntervalSince1970, sunset: 0),
                        wind: Wind(speed: 10),
                        name: "")
    }
}
