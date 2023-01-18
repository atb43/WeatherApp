//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by hope on 1/13/23.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var weatherImage: Data?
    @Published var weather: WeatherEntity = .empty
    @Published var showLoading = false
    @Published var showAlert = false
    
    private let apiClient: APIClient
    private let imageRepository: ImageRepositoryIntf
    private(set) var alertTitle: String = ""
    private(set) var alertMessage: String = ""
    
    init(apiClient: APIClient = APIClient(),
         imageRepository: ImageRepositoryIntf = ImageRepository()) {
        self.apiClient = apiClient
        self.imageRepository = imageRepository
    }
    
    @MainActor
    func getWeather(lat: Double = 33.78591032377107,
                    lon: Double = -84.40964058633683,
                    units: WeatherUnits = .metric) async {
        showLoading = true
        let result = await apiClient.getWeather(lat: lat, lon: lon, units: units)
        showLoading.toggle()
        
        do {
            let weatherResponse = try result.get()
            weather = WeatherEntity(response: weatherResponse, units: units)
            if let weatherIcon = weatherResponse.weather.first?.icon,
               let imageURL = URL(string: "\(Constants.WeatherAPI.baseImageURL)/\(weatherIcon)@2x.png") {
                weatherImage = await imageRepository.getImage(for: imageURL)
            }
        } catch {
            showAlert = true
            alertTitle = AppMessages.error
            alertMessage = AppMessages.failedFeatchWeather
        }
    }
}
