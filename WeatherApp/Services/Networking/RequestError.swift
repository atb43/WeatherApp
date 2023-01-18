//
//  RequestError.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

enum RequestError: Error {
    case invalidRequest
    case invalidResponse
    case networkError(Error)
    case decodingError
    case errorCode(Int)
    case unknownError
}
