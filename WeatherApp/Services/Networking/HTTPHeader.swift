//
//  HTTPHeader.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

enum HTTPHeaderField: String {
    case ContentType = "Content-Type"
    case Authorization = "Authorization"
}

struct HTTPHeader {
    let field: HTTPHeaderField
    let value: String
}
