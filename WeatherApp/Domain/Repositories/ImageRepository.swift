//
//  ImageRepository.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

protocol ImageRepositoryIntf {
    func getImage(for url: URL) async -> Data?
}
