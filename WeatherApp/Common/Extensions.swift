//
//  Extensions.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
