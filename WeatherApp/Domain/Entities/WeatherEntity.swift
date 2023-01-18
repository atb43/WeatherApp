//
//  WeatherEntity.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

struct WeatherEntity {
    let cityName: String
    let temperatureRange: String
    let temperature: String
    let weatherType: String
    let sunriseTime: String
    let wind: String
    let humidity: String
    let units: WeatherUnits
    
    init(response: WeatherResponse, units: WeatherUnits) {
        cityName = response.name
        temperatureRange = "H \(Int(response.main.tempMax))º\(units.temperature) / L \(Int(response.main.tempMin))º\(units.temperature)"
        temperature = "\(Int(response.main.temp))"
        weatherType = response.weather.first?.main ?? ""
        sunriseTime = Date(timeIntervalSince1970: response.sys.sunrise).toString(format: "HH:mm")
        wind = "\(Int(response.wind.speed)) \(units.wind)"
        humidity = "\(response.main.humidity)%"
        self.units = units
    }
    
    static var empty: Self {
        WeatherEntity(response: WeatherResponse.empty, units: .metric)
    }
}
