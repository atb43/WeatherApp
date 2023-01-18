//
//  WeatherUnits.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

enum WeatherUnits: String {
    case imperial
    case metric
    
    var temperature: String {
        switch self {
        case .imperial:
            return "F"
        case .metric:
            return "C"
        }
    }
    
    var wind: String {
        switch self {
        case .imperial:
            return "mph"
        case .metric:
            return "m/s"
        }
    }
}
