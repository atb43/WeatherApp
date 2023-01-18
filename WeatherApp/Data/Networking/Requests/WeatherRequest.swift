//
//  WeatherRequest.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

struct WeatherRequest: Request {
    typealias ResponseType = WeatherResponse
    let path = "/weather"
    let method: HTTPMethod = .GET
    var headers: [HTTPHeader]?
    var queries: [String : String]?
    var body: [String : Any]?
    
    init(lat: Double, lon: Double, units: String, appID: String = Constants.WeatherAPI.appID) {
        queries = [
            "lat": "\(lat)",
            "lon": "\(lon)",
            "units": "\(units)",
            "appid": "\(appID)"
        ]
    }
}
